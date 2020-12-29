# Hologram Speedometer
Hologram Speedometer for FiveM

[![Screenshots](https://i.imgur.com/Kn7kGow.png)](https://www.youtube.com/watch?v=53Rp5ntQfbo)

## Video
- Youtube: https://www.youtube.com/watch?v=53Rp5ntQfbo

## Installation
1. Clone or download this repo
2. Copy the `hologramSpeed` folder to your server resources folder
3. Add `start hologramSpeed` to your server.cfg
4. Restart the server

## Configuration
| Name       | Description                                                                      | Type    | Example                                                          |
| ---------- | -------------------------------------------------------------------------------- | :-----: | ---------------------------------------------------------------- |
| modelName  | The hologram model name, do not change this if you don't know what are you doing | String  | `hologram_box_model`                                             |
| duiUrl     | The url of the UI web page, default page is host on Github                       | String  | `https://kasuganosoras.github.io/hologramSpeed/ui/hologram.html` |
| keyControl | The key to display/hide the speedometer                                          | Number  | `243`                                                            |
| useMph     | Enable or disable MPH display, if set to `false`, it will display KPH            | Boolean | `false`                                                          |
| useNve     | If you using NVE graphic mods, you should turn this on                           | Boolean | `false`                                                          |

## Commands
The base command is: `/hsp`, parameters:
- (No parameter) - Display or hide the speedometer
- `mph` - Enable or disable the MPH display (Need restart game)
- `nve` - Enable or disable the NVE mode (Need restart game)

Example use: `/hsp mph` (Turn on the MPH display)

## FAQ
| FAQ |
| ------------------------------------- |
| __Q: Why my speedometer is blurred?__ |
| A: You should remove your NVE Motion Blur mod and disable motion blur in the game settings. |
| __Q: Why I can't see the speedometer UI? I only can see your avatar.__ |
| A: Check your configuration and make sure your `duiUrl` is correct and accessible. |

If you have any other question, please reply in the FiveM forum, or join our [Discord](https://discord.gg/3KKtpQT) server

## Host your own page
The default UI page is host on the Github. if you want to host the page by yourself, you should:
1. Copy the `ui` folder to your website root folder, such as `D:\Web\MyWebSite\`.
2. Set `duiUrl = "http://your-website-here/ui/hologram.html"` in your `config.lua`.
3. Restart the server.

## License
hologramSpeed - Speedometer script for FiveM

Copyright (C) 2020 Akkariin

This program Is free software: you can redistribute it And/Or modify it under the terms Of the GNU General Public License As published by the Free Software Foundation, either version 3 Of the License, Or (at your option) any later version.

This program Is distributed In the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty Of MERCHANTABILITY Or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License For more details.

You should have received a copy Of the GNU General Public License along with this program. If Not, see http://www.gnu.org/licenses/.
