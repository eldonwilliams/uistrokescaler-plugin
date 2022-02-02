Inspired by [this devforum post](https://devforum.roblox.com/t/make-uistroke-responsive-on-all-screen-size/1463151)

# UIStroke Scaler Plugin

This plugin inserts a script which listens for changes in ViewPort size and scales UIStrokes appropriately. It may be a little off for wildly different aspect ratios, but it's much better than normal (hopefully).

# How to build the plugin for yourself

1. Insert code into Roblox game using Rojo
2. Disable Runner.lua inside of script
3. Config main script to your liking
4. Right-click and `save as local plugin`
5. Done!

# How to use

## Add Tags
This button must be clicked every time a UIStroke is added. It adds the `UIStroke` tag using collection service.

## Add Runner Script
Adds the script that runs the scaling.

## Auto Normalize
This button sets the normal viewport size to your editors viewport size ``workspace.CurrentCamera.ViewportSize``. This Vector2 value is used to base all scaling off of.

## Edit Normalize
Allows you to manually edit the normal viewport size value.