# Hologram Speedometer
Hologram Speedometer for FiveM

[![Screenshots](https://i.imgur.com/Kn7kGow.png)](https://www.youtube.com/watch?v=53Rp5ntQfbo)

## Video
- Youtube: https://www.youtube.com/watch?v=53Rp5ntQfbo

## Installation
1. Clone or download this repo
2. Copy the `hologramspeed` folder to your server resources folder 
3. Make sure that the resource name is all lowercase. The resource will **not** work with uppercase letters in the name!
4. Add `ensure hologramspeed` to your server.cfg
5. Restart the server

## Convars
| Name             | Description                                         | Type   | Example   |
| ---------------- | --------------------------------------------------- | :----: | --------- |
| hsp_defaultTheme | The default theme applied to the speedometer        | String | "default" |

## Commands
- `/hsp` - Toggle the speedometer
- `/hsp theme <name>` - Set the theme of the speedometer, the default theme is `default`.
- `/hsp offset <x> <y> <z>` - Set the offset of the speedometer, leave xyz to blank will reset to default offset.
- `/hsp rotate <x> <y> <z>` - Set the rotate of the speedometer, leave xyz to blank will reset to default rotate.

Example use: `/hsp theme nve` (Set the theme to `nve`, the theme for NaturalVision Evolved)

## FAQ
| FAQ |
| --- |
| __Q: Why my speedometer is blurred?__ |
| A: You should remove your NVE Motion Blur mod and disable motion blur in the game settings. |
| __Q: Why I can't see the speedometer?__ |
| A: Make sure that you have installed the resource correctly. The name of your resource may not be compatible with NUI due to DNS name restrictions. |

If you have any other questions, please reply to the FiveM forums [post](https://forum.cfx.re/t/release-hologram-speedometer/1959568), or join our [Discord](https://discord.gg/3KKtpQT) server.

## License (abridged)
hologramSpeed - Speedometer script for FiveM

Copyright (C) 2020 Akkariin & [Contributors](https://github.com/kasuganosoras/hologramSpeed/contributors)

This program Is free software: you can redistribute it And/Or modify it under the terms Of the GNU General Public License As published by the Free Software Foundation, either version 3 Of the License, Or (at your option) any later version.

This program Is distributed In the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty Of MERCHANTABILITY Or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License For more details.

You should have received a copy Of the GNU General Public License along with this program. If Not, see http://www.gnu.org/licenses/.
