# base16-fish (https://github.com/tomyun/base16-fish)
# based on base16-shell (https://github.com/chriskempson/base16-shell)
# Tomorrow Night scheme by Chris Kempson (http://chriskempson.com)

function base16-tomorrow-night-eighties -d "Tomorrow Night"
  set color00 2d/2d/2d # Base 00 - Black
  set color01 f2/77/7a # Base 08 - Red
  set color02 99/cc/99 # Base 0B - Green
  set color03 ff/cc/66 # Base 0A - Yellow
  set color04 66/99/cc # Base 0D - Blue
  set color05 cc/99/cc # Base 0E - Magenta
  set color06 66/cc/cc # Base 0C - Cyan
  set color07 cc/cc/cc # Base 05 - White
  set color08 99/99/99 # Base 03 - Bright Black
  set color09 $color01 # Base 08 - Bright Red
  set color10 $color02 # Base 0B - Bright Green
  set color11 $color03 # Base 0A - Bright Yellow
  set color12 $color04 # Base 0D - Bright Blue
  set color13 $color05 # Base 0E - Bright Magenta
  set color14 $color06 # Base 0C - Bright Cyan
  set color15 ff/ff/ff # Base 07 - Bright White
  set color16 f9/91/57 # Base 09
  set color17 a3/68/5a # Base 0F
  set color18 39/39/39 # Base 01
  set color19 51/51/51 # Base 02
  set color20 b4/b7/b4 # Base 04
  set color21 e0/e0/e0 # Base 06
  set colorfg $color07 # Base 05 - White
  set colorbg $color00 # Base 00 - Black

  if test -n "$TMUX"
    # Tell tmux to pass the escape sequences through
    # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
    function put_template; printf '\ePtmux;\e\e]4;%d;rgb:%s\e\e\\\e\\' $argv; end;
    function put_template_var; printf '\ePtmux;\e\e]%d;rgb:%s\e\e\\\e\\' $argv; end;
    function put_template_custom; printf '\ePtmux;\e\e]%s%s\e\e\\\e\\' $argv; end;
  else if string match 'screen*' $TERM # [ "${TERM%%[-.]*}" = "screen" ]
    # GNU screen (screen, screen-256color, screen-256color-bce)
    function put_template; printf '\eP\e]4;%d;rgb:%s\a\e\\' $argv; end;
    function put_template_var; printf '\eP\e]%d;rgb:%s\a\e\\' $argv; end;
    function put_template_custom; printf '\eP\e]%s%s\a\e\\' $argv; end;
  else if string match 'linux*' $TERM # [ "${TERM%%-*}" = "linux" ]
    function put_template; test $1 -lt 16 && printf "\e]P%x%s" $1 (echo $2 | sed 's/\///g'); end;
    function put_template_var; true; end;
    function put_template_custom; true; end;
  else
    function put_template; printf '\e]4;%d;rgb:%s\e\\' $argv; end;
    function put_template_var; printf '\e]%d;rgb:%s\e\\' $argv; end;
    function put_template_custom; printf '\e]%s%s\e\\' $argv; end;
  end

  # 16 color space
  put_template 0  $color00
  put_template 1  $color01
  put_template 2  $color02
  put_template 3  $color03
  put_template 4  $color04
  put_template 5  $color05
  put_template 6  $color06
  put_template 7  $color07
  put_template 8  $color08
  put_template 9  $color09
  put_template 10 $color10
  put_template 11 $color11
  put_template 12 $color12
  put_template 13 $color13
  put_template 14 $color14
  put_template 15 $color15

  # 256 color space
  put_template 16 $color16
  put_template 17 $color17
  put_template 18 $color18
  put_template 19 $color19
  put_template 20 $color20
  put_template 21 $color21

  # foreground / background / cursor color
  if test -n "$ITERM_SESSION_ID"
    # iTerm2 proprietary escape codes
    put_template_custom Pg cccccc # foreground
    put_template_custom Ph 2d2d2d # background
    put_template_custom Pi cccccc # bold color
    put_template_custom Pj 515151 # selection color
    put_template_custom Pk cccccc # selected text color
    put_template_custom Pl cccccc # cursor
    put_template_custom Pm 2d2d2d # cursor text
  else
    put_template_var 10 $colorfg
    if [ "$BASE16_SHELL_SET_BACKGROUND" != false ]
      put_template_var 11 $colorbg
      if string match 'rxvt*' $TERM # [ "${TERM%%-*}" = "rxvt" ]
        put_template_var 708 $colorbg # internal border (rxvt)
      end
    end
    put_template_custom 12 ";7" # cursor (reverse video)
  end

  # set syntax highlighting colors
  set -U fish_color_autosuggestion 515151
  set -U fish_color_cancel -r
  set -U fish_color_command green #white
  set -U fish_color_comment 515151
  set -U fish_color_cwd green
  set -U fish_color_cwd_root red
  set -U fish_color_end brblack #blue
  set -U fish_color_error red
  set -U fish_color_escape yellow #green
  set -U fish_color_history_current --bold
  set -U fish_color_host normal
  set -U fish_color_match --background=brblue
  set -U fish_color_normal normal
  set -U fish_color_operator blue #green
  set -U fish_color_param b4b7b4
  set -U fish_color_quote yellow #brblack
  set -U fish_color_redirection cyan
  set -U fish_color_search_match bryellow --background=515151
  set -U fish_color_selection white --bold --background=515151
  set -U fish_color_status red
  set -U fish_color_user brgreen
  set -U fish_color_valid_path --underline
  set -U fish_pager_color_completion normal
  set -U fish_pager_color_description yellow --dim
  set -U fish_pager_color_prefix white --bold #--underline
  set -U fish_pager_color_progress brwhite --background=cyan

  # remember current theme
  set -U base16_theme tomorrow-night-eighties

  # clean up
  functions -e put_template put_template_var put_template_custom
end
