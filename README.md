# docker-chromium
Chromium Docker Image

## Prerequisites
* X server installed on host OS (must be with a window manger)
* Allow connections to the X server. Either by running *xhost +* as the user starting the X session on the host OS from cli, or by entering *xhost +* into the *~/.xsessionrc* file as the user starting the X session on the host OS (create the file if it doesn't exist)

## Supported GFX drivers
* nvidia, nouveau, radeon, i810, i815, i830, i845, i855, i865, i915, i945, i965
* Other drivers are probably supported too. If your driver is not listed above, try to run the container without the GFX_DRIVER parameter and report back if it works.


## Usage
```
docker run -d --privileged -v /tmp:/tmp -e GFX_DRIVER=<driver> --name=chromium nicjo814/docker-chromium
```

## Sound config

If you do not have sound in chromium, you might have to create asound.conf. To find out what to put in asound.conf, we first have to execute some commands in the terminal. The first one is ```aplay -l```. This will show a list of your sound devices available in your system.
It might look like below.
```
**** List of PLAYBACK Hardware Devices ****
card 0: NVidia [HDA NVidia], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: NVidia [HDA NVidia], device 7: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: NVidia [HDA NVidia], device 8: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: NVidia [HDA NVidia], device 9: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
```

What we need from this list is the card number and the device number. If you know which one is your correct device, you can skip down to creating the asound.conf file.
If you do not know which is the correct device, you have to run a test on each device. Remember to turn your speakers on and not too loud, as there will be some static noise playing.
Run the below command and substitute the numbers after hw to the ones you found in the above list. the first number is the card and the second number the device. This test will alternate between left and right channel until you ctrl+c out of it.

```speaker-test -c 2 -r 48000 -D hw:0,3```

When you hear sound from your speakers, you have found the correct device and we can create asound.conf. It should look like below.

```
pcm.!default {
        type plug slave.pcm {
                type hw card 0 device 7
        }
}
```

The only thing you have to change is the card number and device number in line 3. In the above example, the correct sound device is card 0 and device 7.
To add the asound.conf file to the container, you have to add it in the folder you have mapped to /config. If you haven't made a volume mapping for /config, you need to recreate the container using the docker run command in the uasge section and add the below somewhere before ```nicjo814/docker-chromium```.

```-v /path/to/the/host/folder:/config```

Adding the above to the docker run command will also make settings stick if you have to re-create the container in case of an update.
