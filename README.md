<!-- PROJECT LOGO
<p align="center">
  <a href="https://github.com/revokeHQ/rdconfig">
    <img src="images/logo.png" alt="Logo">
  </a>
</p>
-->

<!-- PROJECT SHIELDS
<p align="center">
  <a href="https://github.com/revokehq/revoke/"><img src="https://img.shields.io/badge/build-passing-brightgreen.svg" alt="Build Status"></a>
  <img src="https://img.shields.io/github/contributors/revokehq/revoke.svg" alt="Contributors">
  <a href="LICENSE"><img src="https://img.shields.io/github/license/revokehq/revoke.svg" alt="License"></a>
  <a href="https://github.com/revokehq/revoke/releases"><img src="https://img.shields.io/github/release/revokehq/revoke.svg" alt="Latest Stable Version"></a>
  <a href="https://bestpractices.coreinfrastructure.org/projects/2731"><img src="https://bestpractices.coreinfrastructure.org/projects/2731/badge"></a>
</p>
-->

# rdConfig

## Overview

Automates the customization and configuration of Netgear retransmission devices. 

- Bases configuration on pre-configured default configuration
- Rewrites key variables with custom values
- Automatic upload of configuration to device via CURL
- Supports an unlimited number of custom variables
- Netgear / AT&T Unite Explore

## Requirements
- Powershell 5.1+
- .NET support for `System.Web.HttpUtility` Class
- Curl 7.29+

## Installation

Installation instructions here.

## Usage

1. Copy fully configured sample configuration to `\conf\default.conf`
2. Edit `.source.txt`
   * The first line of file are the names of variables to be edited, values delimited by spaces.
   * Each subsequent line will be used as the variable values.
 ```
.source.txt

deviceSSID devicePIN wwwPassword pskPassword
device101 12345 Password1 Password1234
device102 67890 Password2 Password5678
```

## Security Vulnerabilities

If you discover a security vulnerability within rdconfig, please send an e-mail to [cavella_tony@bah.com](mailto:cavella_tony@bah.com?rdConfig%20Security%20Vulnerability). Security vulnerabilities are taken very seriously and will be addressed with the utmost priority.

## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

Distributed under the GNU General Public License v3.0. See `LICENSE` for more information.

## Contact

Tony Cavella - cavella_tony@bah.com

Project Link: [https://github.com/revokehq/rdconfig](https://github.com/revokehq/rdconfig)

<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements
* [Choose an Open Source License](https://choosealicense.com)
* [Markdown Cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)
* [Semantic Version](https://semver.org)
