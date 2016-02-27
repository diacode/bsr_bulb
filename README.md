# BSRBulb
<img align="right" src="https://raw.githubusercontent.com/diacode/bsr_bulb/master/web/bsr_bulb.jpg", width="400">

An Elixir library for interacting with a [BSR Smart Bulb](https://www.youtube.com/watch?v=bFEzDolYsK0)
that is connected via bluetooth. This an RGB LED Bulb with built-in speaker.

It seems there are others brands that sell this bulb under his own name. Some of
them are:

* [1byone](http://www.amazon.es/inal%C3%A1mbrica-multicolor-aplicaci%C3%B3n-controlada-compartible/dp/B00X9NCS00/ref=cm_cr_pr_product_top?ie=UTF8)
* ...

In order to reverse engineering the Bluetooth protocol of the bulb we used the Bluetooth HCI snoop log from Android, to capture the bluetooth packets between the [mobile app](http://www.chbsr.com/index.asp?classid=17) and the smart bulb, and Wireshark to analyze the packets. You can read more about this approach [here](http://www.guillier.org/blog/2015/04/reverse-engineering-of-a-ble-bulb/).

## Supported features

* Switch on
* Switch off
* Set color

## Usage

On Mac OS X, pair your computer with your bulb by using the normal Bluetooth
device explorer. One connected, you should hear a sound coming from the
bulb's speaker.

Then you need to find the serial port for your bulb. You can use `ls /dev | grep tty`. For the 1byone version the port is `/dev/tty.1byoneBulb-SerialPortSe`.

Then open an elixir terminal with `iex -S mix` and type:

```elixir
device = "/dev/tty.1byoneBulb-SerialPortSe"
{:ok, bulb} = BSRBulb.Client.start(device)
BSRBulb.Client.switch_on(bulb)
BSRBulb.Client.set_color(bulb, "#ff0000") # Red
BSRBulb.Client.switch_off(bulb)
```

## Acknowledgments

This library was based on the [Sphero](https://github.com/knewter/sphero) library. While the bulb and Sphero are different devices both are
controlled through Bluetooth using [erlang-serial](https://github.com/knewter/erlang-serial).
