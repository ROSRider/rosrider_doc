This package contains launch files to launch camera, and image processing node for image rectification, also example nodes which use OpenCV, for autonomous lane following  

- `color_filter`  
- `lane_filter`  
- `homography_calibration`  
- `birds_eye_filter`  


### color_filter

To run:  

	roscd rosrider_image/nodes
	./color_filter.py _debug:=True

Takes input image at `/camera/image_raw` and selects yellow, white, and red on three different masks. In order to accomplish this, input
image is inverted and then converted to HSV color space. Then ranges for each yellow, white, and red are filtered, to different masks.

Each mask is eroded and then dilated to get rid of noise, and then canny edge detector runs on mask, which are combined together to form a RGB image.
This RGB image contains yellow, white and red edges in each channel, and published at `/camera/filter_image`

**Arguments:**

~debug: if  True is specified, will display the color filtered image, and the edge image. This is useful when tuning.

~input: input image, default is `/camera/image_raw`

**Filter Image**  
Colors yellow, red, and white are filtered with their HSV ranges, and masked. Using rqt_reconfigure you can select the ranges according to your lighting conditions.

![filter_image](https://raw.githubusercontent.com/ROSRider/rosrider_doc/main/img/filter_image.png)

**Edge Image**  
Green channel contains the detected yellow edges. Blue channel contains the detected white edges. Red channel contains the detected red edges. The canny edge detection thresholds t1 and t2 can also be configured with `rqt_reconfigure`.

![filter_image_edges](https://raw.githubusercontent.com/ROSRider/rosrider_doc/main/img/filter_image_edges.png)


**color calibration**

After starting the color\_filter with `_debug:=True` argument, open another terminal and execute:

	rosrun rqt_reconfigure rqt_reconfigure


The reconfigure window will pop up. We filter between the low and high of each channel, for each detected color. `yellow_h_low` and `yellow_h_high` are yellow detectors, H channels, high and low respectively.

Remember we are operating on the inverse HSV of the image, i.e. the input image is inverted first.

Start with a wide filter from min to max. Then reduce from bottom, to see if you are still getting the colored area you want. Then reduce from top, and see if you are still getting the colored area. Repeat for each H, S, V channels, until you only get the color you want in the screen.

Try to select a broad range, so when the robot moves, or light conditions change, it will still be working. You might also play with lighting conditions.

![filter_image_edges](https://raw.githubusercontent.com/ROSRider/rosrider_doc/main/img/image_dyn_reconfig.png)


### lane filter

To run:  

	roscd rosrider_image/nodes
	./lane_filter.py _debug:=True

Lane filter uses probabilistic hough line detection, from the edge image that the color image publishes. Each channel is processed seperately, for detecting yellow, white and red lines.

After lines are detected, each line's slope is measured, and whether they will be used for the calculation of lane is filtered accordingly. In the image below, The lines that are 1px wide are lines that will not be used for determination of lane, since they are horizontal, i.e. slope < 0.5. So these lines are drawn as 1px lines, and the others are drawn as 2px lines.

For put each eligible line in a list, and then use a polynomial fit to get one line that represents where the lane is. The thicker magenta line on the left is the detected yellow lane. The cyan line on the left is the detected white lane.

![lane_filter](https://raw.githubusercontent.com/ROSRider/rosrider_doc/main/img/lane_filter.png)

**lane filter tuning:**

Open a terminal and execute:

	rosrun rqt_reconfigure rqt_reconfigure


The reconfigure window will pop up. For each channel, we have rho, angle, minThreshold, minLineLength, and maxLineGap.

![lane_dyn_reconfig](https://raw.githubusercontent.com/ROSRider/rosrider_doc/main/img/lane_dyn_reconfig.png)

`rho` is pixel precision.

`angle` determines angular precision in terms of `np.pi/angle`, therefore 180 is 1 degree angular precision.

`min_threshold` determines the number of votes for the line to be valid.

`minLineLength` determines the minimum length of the detected lines.

`maxLineGap` determines how many pixels of a gap there can be between two lines, for them to be considered single line.

At the beginning start with `rho=1`, `angle=180`, and `min_threshold=10` for each channel.
Adjust `minLineLength` first, increase in order to filter out small lines. Then adjust `maxLineGap` in order to join split lines together.

You might want different parameters for different colors, the white lines can have a longer `minLineLength` i.e.  Adjust `minLineLength` and `maxLineGap` for each channel until detection is done efficiently at all around the tracks. Move your robots to different locations to see if the calibration parameters hold for those conditions

#### intrinsic camera calibration  

Intrinsic calibration refers to the distortion of the lens. Once the distortion parameters are known, the image can be rectified.

Follow instructions on: [Camera Calibration](http://wiki.ros.org/camera_calibration)

#### extrinsic camera calibration

Extrinsic calibration refers to detecting ground homography. That is to say, which pixel on the camera corresponds to which pixel on the ground.

First obtain the [calibration_pattern](https://raw.githubusercontent.com/duckietown/Software/master18/catkin_ws/src/00-infrastructure/duckietown/config/baseline/calibration/camera_intrinsic/calibration_pattern.pdf) and print it on 2 sheets of A4 paper. Then place your robot as shown in the picture below:

![calibration_pad](https://raw.githubusercontent.com/ROSRider/rosrider_doc/main/img/calibration_pad.png)

Assuming that camera is already launched, we run:

	roscd rosrider_image/nodes
	./ground_homography.py

Also run:

	rosrun rqt_reconfigure rqt_reconfigure

You will see the following windows:

![ground_homography_calibration](https://raw.githubusercontent.com/ROSRider/rosrider_doc/main/img/ground_homography_calibration.png)  

Adjust `t1` until the vertical lines are parallel to each other. Image will turn to a V shape. After the vertical lines are parallel, adjust `t2` to compress image until the checkers are square. You should see something like:

![ground_homography_calibrated](https://raw.githubusercontent.com/ROSRider/rosrider_doc/main/img/ground_homography_calibrated.png)

There is also `h1` and `h2`, although those parameters are optional.

Adjust `h1` to see further in birds image view. Increase `h1` to somewhere between 40 and 60, and then retune `t1` and `t2` to get parallel lines again. Adjust `h2` to change view angle towards the robot.

After the desired output is achieved, look at the window that you are running the `homography_calibration`, you should see it is constantly printing a 3x3 matrix. Copy the values and save it in a file.

![homography_matrix](https://raw.githubusercontent.com/ROSRider/rosrider_doc/main/img/homography_matrix.png)

### birds eye filter

The `homography_calibration` node, calculates the matrix for perspective transformation for each frame, which can be time consuming. `birds_eye_filter` node does the perspective transformation, given a h matix.

Edit `birds_eye_filter.py`:

	roscd rosrider_image/nodes
	nano birds_eye_filter.py


Find the where the h matrix is defined:

	        self.h = np.float32([[-4.00900901e-01, - 1.86786787e+00,  5.60360360e+02],
                 [3.09125536e-17, -1.40540541e+00,  4.21621622e+02],
                 [-2.90964404e-19, -4.66966967e-03, 1.00000000e+00]])

Plug in the values that you have obtained in the previous steps. (it requires inserting commas)

Then run:

	roscd rosrider_image/nodes
	./birds_eye_filter.py

And then from another window run:

	rqt_image_view /camera/top_image

You will see the birds eye view from the camera. 

![birds_eye](https://raw.githubusercontent.com/ROSRider/rosrider_doc/main/img/birds_eye.png)

Here is another setting for the same filter. As you see, the closer we are to the camera, the more information the image has, and as we go further way from the camera, we have less information about the texture. In the code there is the `self.h` matrix for normal operation, and `self.H` matrix for far operation.

![birds_eye_far](https://raw.githubusercontent.com/ROSRider/rosrider_doc/main/img/birds_eye_far.png)

### image processing pipelines

Each imaging filter has the private `~input` parameter, that allows to select which image to process.

Here is an example pipeline:

	<launch>
	  <node name="color_filter" pkg="rosrider_image" type="color_filter.py" output="screen"></node>
	  <node name="lane_filter" pkg="rosrider_image" type="lane_filter.py" output="screen"></node>
	  <node name="birds_eye_filter" pkg="rosrider_image" type="birds_eye_filter.py" output="screen">
	    <param name="input" value="/camera/filter_image" />
	  </node>
	</launch>


Upon launch, `color_filter` will process the default `/camera/image_raw` and will publish output to `/camera/filter_image`

The second node, `lane_filter` will listen to `/camera/filter_image` and output at `/camera/lane_image`

The third node, `birds_eye_filter` by default listens to `/camera/image_raw` but however in this pipeline we define the input parameter for to listen to `/camera/filter_image`. 

The `birds_eye_filter` publishes output to `/camera/top_image`. 

You can also remap the output of any filter using `<remap>`, and you put image processing filters at any sequence, thus constructing an image processing pipeline.