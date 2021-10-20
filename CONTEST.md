# Tiling WM Mastery Chat Scripts Contest

## Results board

### Candidates

* NackNime [auto keyboard switch script](https://github.com/twmru/scripts/pull/4)
* LazinessItself [i3-vimonised](https://github.com/0Karakurt0/i3-vimonised)
* HeyLazySunnyKid [heyteiler extension](https://github.com/HeyLazySunnyKid/heyteiler/releases/tag/v4.0-beta)

### Scores

* Is the code working, or not
* Usefullness
* Usability (guides, installation, ease of use)
* Configurability

| Script | Workability | Usefullness | Usability | Configurability |
|:---|---|---|---|---:|
| smart layout | 3 | 2 (has analog written in C) | 2 (could be implemented in systemd user unit) | 1 (could be more configurable, for example apps white/black listing, persistent layouts and stuff) |
| i3-vimonised | 1 (has no installation instructions, copying into `.config/i3` didn't work) | 3 (idea is great btw) | 2 (no installation instructions, no guides, but has keybindings in `README.md`) | 2 (has no configuration, personal programs included in config) |
| heyteiler | 2 (recognition failed to detect OpenGL backend) | 3 | 2 (Images from clipboard are saved without extenstion) | 2 (There is not much can be configured) |

Winner is heytailer with `2 + 3 + 2 + 2 = 9` points!

## Rules

### What can be done

* Script for specific tiling wm
* Extension for existing tiling wm
* WM configuration tooling
* Styles/colors configuration tooling

### How it must be done

* Original code, but it is allowed to rely on any external dependencies
* Should have LICENCE allowing to modify and distribute your code
  > It is suggested to have Apache 2.0
* Code must be implemented in separate repository or as a PR for `twmru/scripts`
* Code must have build instruction (if required)

### Submission

* Project is submitted to the contest if [Judge](https://t.me/lamalove) receives link to your project or `PR`
* Projects must be submitted earlier than this contests finish

## Judgement

### How will the winner be chosen

Every project will be scored from 0 to 3 for each criteria
plus an extra point for each completed extra point
Projects with maximum summarised score are winning projects.

### Criteria:

* Is the code working, or not
* Usefullness
* Usability (guides, installation, ease of use)
* Configurability

### Extra point for:

* Documentation in English
* Code quality

## Dates

Contest will start at **3PM at 19 Dec 2020** and will finish at **6PM at 30 Dec 2020**
