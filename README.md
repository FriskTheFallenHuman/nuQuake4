# nuQuake4
---

> [!TIP]
> We have a discord server, feel free to join the discussion, the invite is [here.](https://discord.gg/tJDGrk6w4H)

> [!CAUTION]
> You **MUST** source your own legal copy of Quake 4 to run this, i wouldn't provide any links for this.
> i've been getting a lot of questions about but, please keep in mind this is just a source port.

> [!IMPORTANT]
> We are currently looking for contributors that wants to contribute into this project.

## Introduction

Source port for Quake 4 base on the Quake 4 Awakening's reverse engineer executable by [jmarshall23](https://github.com/jmarshall23)

## Compiling

For Windows:

- Clone the repo.
- Install [Visual Studio 2019](https://visualstudio.microsoft.com/vs/older-downloads/) or Visual [Visual Studio 2022](https://visualstudio.microsoft.com/vs/)
- [CMake](https://cmake.org/download/)
- Run either **cmake_msvc.cmd**

For Debian/Ubuntu

- Intall the dependencies
  - ```sudo apt install libgl1-mesa-dev libsdl2-dev libopenal-dev libcurl4-openssl-dev cmake ninja-build```
- Make **cmake_linux.sh** a executable and execute with
  - ```./cmake_linux.sh gcc release```

For other Linux Distros: It should compile just fine in theory.

## Know issues:

- NO AUDIO AT ALL.
- NO MAIN MENU AT ALL.
- SCOPE SHADER DOES NOT WORK AT ALL.
- AFS HAS NO COLLISION AT ALL.
- THE GAME CRASHES AT SHUTDOWN.

## Credits

This fork wouldn't be possible by the 3 previous attempts of porting Prey before me:

- [Quake 4/IcedTech4](https://github.com/jmarshall23/IcedTech4)
