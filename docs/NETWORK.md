### Networking

**Ideal Network Setup for ROS**

![Ideal Network Setup for ROS](https://raw.githubusercontent.com/ROSRider/rosrider_doc/main/img/networking.png)

The prefererred way of networking is that you have your laptop attached to ethernet, connected to router, and your robot connected over 5.8Ghz WiFi.

The robot runs a RaspberryPI, with a USB Wireless Adapter EW-7822UTC. You can also use the built in wireless adapter, but we recomend the EW-7822UTC for faster communication.

In order for ROS networking to work, in the diagram above both hosts must be able to resolve each other.

In order for `.local` domainname resolution, install `libnss-mdns` on both your laptop and robot:

```console
sudo apt install libnss-mdns
```


Open a terminal in your laptop and:

```console
ping robot.local
```

and you should be getting replies.

Login remotely to your robot and:

```console
ping laptop.local
```

and you should be getting replies.

If both sides can not ping each other ROS will not work. This is important for containerization. If your ROS node is running in a container, make sure that it can resolve and connect other nodes.

### ROS\_MASTER\_URI

`ROS_MASTER_URI` tells ROS programs where to connect to contact `roscore`

On the client it should point to the robot, and on the robot it should point to itself.

### ROS_HOSTNAME

 `ROS_HOSTNAME` tells ROS programs what is the name of the current node, so others could connect to it.

On the Laptop, add this to `~/.bashrc`

```console
export ROS_MASTER_URI=http://robot.local:11311
export ROS_HOSTNAME=laptop.local
```

On the Robot, add this to `~/.bashrc`

```console
export ROS_MASTER_URI=http://127.0.0.1:11311
export ROS_HOSTNAME=robot.local
```

While your robot is running roscore, execute the following command at laptop to test:

```console
rostopic list
```

Should return:

```console
/rosout
/rosout_agg
```


### TROUBLESHOOTING

There are two modes of failure.

1. `rostopic list` returns topics, but `rostopic echo /odom` will not stream data

	**REASON:** `ROS_MASTER_URI` is set correctly, but the client is unable to contact the `host:port` that publishes the `/odom`
	
	**SOLUTION:** Use `rostopic info /odom` to get information on which node publishes the `odom` at which `host:port`, and make sure that both hosts can communicate.
	
2. `rostopic echo /odom` streams data, but `rostopic pub /topic` will not send to the robot.
	
	**REASON:**`ROS_MASTER_URI` is set correctly, but the `ROS_HOSTNAME` given could not be contacted by robot.
	
	**SOLUTION:** Make sure `ROS_HOSTNAME` is set correctly, and make sure value given in `ROS_HOSTNAME` can be reached from robot.