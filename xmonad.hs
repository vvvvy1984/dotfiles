import XMonad
import XMonad.Hooks.SetWMName
import System.IO
import XMonad.Layout.Reflect
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
 
-- The main function.
main = xmonad =<< statusBar "xmobar" myPP toggleStrutsKey myConfig

-- Custom PP, configure it as you like. It determines what's being written to the bar.
myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }

-- Keybinding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

defaultLayouts = avoidStruts $ tiled ||| Full ||| reflectHoriz tiled ||| Full
                 where
                   tiled = Tall nmaster delta ratio
                   nmaster = 1
                   ratio = 2/3
                   delta = 3/100

myConfig = defaultConfig
            { modMask = mod4Mask
            , layoutHook = defaultLayouts
            , focusFollowsMouse = False
            , startupHook = setWMName "LG3D"
	    }