{ pkgs, lib, ... }:

let
  inherit (builtins) genList map replaceStrings;
  inherit (lib) toLower listToAttrs mapAttrs' nameValuePair foldl recursiveUpdate;

  renameAttrs = f: mapAttrs' (name: value: nameValuePair (f name) value);
  genAttrs' = values: f: listToAttrs (map f values);
  recursiveMerge = foldl recursiveUpdate { };

  modifier = "Mod4";
  terminal = "alacritty";

  movementKeys = [ "Left" "Down" "Up" "Right" ];
  vimMovementKeys = [ "h" "j" "k" "l" ];

  toVimKeyBindings =
    let
      toVimKeys = replaceStrings movementKeys vimMovementKeys;
    in
    renameAttrs toVimKeys;

  addVimKeyBindings = bindings: bindings // (toVimKeyBindings bindings);
  genMovementBindings = f: addVimKeyBindings (genAttrs' movementKeys f);

  toKeycode = n: if n == 10 then 0 else n;
  createWorkspaceBindings = mapping: command:
    let
      createWorkspaceBinding = num:
        nameValuePair
          "${mapping}+${toString (toKeycode num)}"
          "${command} \$ws${toString num}";
      oneToTen = genList (x: x + 1) 10;
    in
    genAttrs' oneToTen createWorkspaceBinding;

  makeModeBindings = attrs: (addVimKeyBindings attrs) // {
    "Escape" = "mode default";
    "Return" = "mode default";
  };

in
{
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    # extraPackages = with pkgs; [
    #   i3status
    #   rofi
    #   betterlockscreen
    # ];

    config = {
      inherit modifier;

      fonts = {
        names = [ "Mononoki Nerd Font" ];
        style = "Regular";
        size = 10.0;
      };

      keybindings = recursiveMerge [
        (
          genMovementBindings (
            key: nameValuePair
              "${modifier}+${key}"
              "focus ${toLower key}"
          )
        )
        (
          genMovementBindings (
            key: nameValuePair
              "${modifier}+Shift+${key}"
              "move ${toLower key}"
          )
        )
        (
          genMovementBindings (
            key: nameValuePair
              "${modifier}+Shift+${key}"
              "move ${toLower key} 10 px"
          )
        )
        {
          "${modifier}+b" = "split h";
          "${modifier}+v" = "split v";
        }
        {
          "${modifier}+q" = "focus parent";
          "${modifier}+a" = "focus child";
        }
        {
          "${modifier}+s" = "layout stacking";
          "${modifier}+z" = "layout tabbed";
          "${modifier}+w" = "layout toggle split";
        }
        {
          "${modifier}+Shift+Q" = "kill";
          "${modifier}+f" = "fullscreen toggle";
          "${modifier}+Return" = "exec ${terminal}";
          "${modifier}+t" = "exec ${terminal}";
          "${modifier}+Shift+e" = "exec \"i3-nagbar -t warning -m 'exit?' -B 'Yes' 'i3-msg exit'\"";
          "${modifier}+Shift+c" = "reload";
          "${modifier}+Shift+r" = "restart";
          "${modifier}+Shift+space" = "floating toggle";
          "${modifier}+i" = ''exec --no-startup-id "pkill -u $USER -USR1 dunst; betterlockscreen --lock; pkill -u $USER -USR2 dunst"'';
          "${modifier}+Shift+x" = ''exec --no-startup-id "sh -c source /home/prrlvr/.screeenlayout/reset.sh"'';
          "${modifier}+Shift+z" = ''exec "sh -c source /home/prrlvr/.screeenlayout/lab.sh"'';
        }
        {
          "${modifier}+space" = "exec rofi -show run";
        }
        {
          "${modifier}+r" = "mode resize";
        }
        {
          "${modifier}+e" = "exec emacsclient --create-frame";
          "${modifier}+b" = "exec firefox";
          "${modifier}+g" = ''exec "firefox"'';
        }
        {
          "XF86AudioRaiseVolume" = "exec pactl set-sink-volume 0 +5%";
          "XF86AudioLowerVolume" = "exec pactl set-sink-volume 0 -5%";
          "XF86AudioMute" = "exec pactl set-sink-mute 0 toggle";
          "XF86AudioMicMute" = "exec test";
        }
        {
          "XF86MonBrightnessUp" = "exec light -A 10";
          "XF86MonBrightnessDown" = "exec light -U 10";
        }
        (createWorkspaceBindings modifier "workspace")
        (createWorkspaceBindings "${modifier}+Shift" "move container to workspace number")
      ];

      window = {
        hideEdgeBorders = "none";
      };

      gaps = {
        smartBorders = "on";
        inner = 7;
        outer = 0;
      };

      colors = {
        focused = {
          border = "$bg-color";
          background = "$bg-color";
          text = "$text-color";
          indicator = "$indicator";
          childBorder = "$bg-color";
        };

        unfocused = {
          border = "$inactive-bg-color";
          background = "$inactive-bg-color";
          text = "$inactive-text-color";
          indicator = "$indicator";
          childBorder = "$bg-color";
        };

        focusedInactive = {
          border = "$inactive-bg-color";
          background = "$inactive-bg-color";
          text = "$inactive-text-color";
          indicator = "$indicator";
          childBorder = "$bg-color";
        };

        urgent = {
          border = "$urgent-bg-color";
          background = "$urgent-bg-color";
          text = "$text-color";
          indicator = "$indicator";
          childBorder = "$bg-color";
        };
      };

      focus = {
        followMouse = false;
      };

      bars = [
        {
          position = "top";
          statusCommand = "i3status";
        }
      ];

      modes = {
        resize = (makeModeBindings {
          "Left" = "resize shrink width 10 px or 10 ppt";
          "Down" = "resize grow height 10 px or 10 ppt";
          "Up" = "resize shrink height 10 px or 10 ppt";
          "Right" = "resize grow width 10 px or 10 ppt";

          "Shift+Left" = "resize shrink width 1 px or 1 ppt";
          "Shift+Down" = "resize grow height 1 px or 1 ppt";
          "Shift+Up" = "resize shrink height 1 px or 1 ppt";
          "Shift+Right" = "resize grow width 1 px or 1 ppt";
        }) // { "${modifier}+r" = "mode default"; };
      };
    };

    extraConfig = ''
      exec_always --no-startup-id $HOME/.fehbg
      exec_always --no-startup-id xss-lock -- betterlockscreen --lock
      exec_always --no-startup-id $HOME/.config/polybar/launch.sh
      exec_always --no-startup-id flameshot & disown

      set $bg-color            #2f343f
      set $inactive-bg-color   #2f343f
      set $text-color          #f3f4f5
      set $inactive-text-color #676E7D
      set $urgent-bg-color     #E53935
      set $indicator           #00ff00

      set $ws1 "1"
      set $ws2 "2"
      set $ws3 "3"
      set $ws4 "4"
      set $ws5 "5"
      set $ws6 "6"
      set $ws7 "7"
      set $ws8 "8"
      set $ws9 "9"
      set $ws10 "10"

      new_window pixel 1
      new_float normal
    '';
  };

  home.file = {
    ".background-image".source = ./background.jpg;
    # ".lock.png".source = ./lock.png;
    ".scripts/system_status/volumeControl.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        # You can call this script like this:
        # $ ./volumeControl.sh up
        # $ ./volumeControl.sh down
        # $ ./volumeControl.sh mute
        function get_volume {
          amixer -M get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
        }
        function is_mute {
          amixer -M get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
        }
        function send_notification {
          iconSound="audio-volume-high"
          iconMuted="audio-volume-muted"
          if is_mute ; then
            dunstify -t 1000 -i $iconMuted -r 2593 -u normal "mute"
          else
            volume=$(get_volume)
            bar=$(seq --separator="─" 0 "$((volume / 5))" | sed 's/[0-9]//g')
            dunstify -t 1000 -i $iconSound -r 2593 -u normal "$volume%"$'\n'"$bar"
          fi
        }
        case $1 in
        up)
          pamixer --allow-boost -i 5
          send_notification
        ;;
        down)
          pamixer --allow-boost -d 5
          send_notification
        ;;
        mute)
          pamixer --toggle-mute
          send_notification
        ;;
        esac
      '';
    };

    ".scripts/system_status/brightnessControl.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        # You can call this script like this:
        # $ ./brightnessControl.sh up
        # $ ./brightnessControl.sh down
        function send_notification {
          icon="notification-display-brightness"
          brightness="$1"
          bar=$(seq -s "─" 0 $((brightness / 5)) | sed 's/[0-9]//g')
          dunstify -t 1000 -i "$icon" -r 5432 -u normal "$brightness%"$'\n'"$bar"
        }
        case $1 in
          up)
            newBrightness=$(brightnessctl -m set "+2%" | cut -d, -f4 | tr -d '%')
            send_notification "$newBrightness"
            ;;
          down)
            newBrightness=$(brightnessctl -m set "2%-" | cut -d, -f4 | tr -d '%')
            send_notification "$newBrightness"
            ;;
        esac
      '';
    };

    ".config/polybar/launch.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env sh
        # multiple monitors
        if ! pgrep polybar; then
            if type "xrandr"; then
              for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
                MONITOR=$m polybar mybar &
              done
            else
              polybar --reload mybar &
            fi
        else
            pkill polybar
            if type "xrandr"; then
              for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
                MONITOR=$m polybar mybar &
              done
            else
              polybar --reload mybar &
            fi
        fi
        echo "Bars launched..."
      '';
    };
  };
}
