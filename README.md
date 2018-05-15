# xcode-presets

Custom Xcode presets—simply run the install script and you're good to go.

## Usage

### Installing Presets

Install via Wget:

```sh
$ wget -qO- https://raw.githubusercontent.com/andrewscwei/xcode-presets/master/install.sh | bash
```

Relaunch Xcode and go to **Preferences**:

1. Go to **Key Bindings** and change **Key Binding Set** to *Custom*
2. Go to **Fonts and Colors** and select your favorite theme

### Exporting Current Xcode presets

```sh
$ git clone https://github.com/andrewscwei/xcode-presets
$ cd xcode-presets
$ ./export.sh
```

## License

This software is released under the [MIT License](http://opensource.org/licenses/MIT).
