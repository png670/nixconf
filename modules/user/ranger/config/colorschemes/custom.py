from ranger.colorschemes.default import Default
from ranger.gui.color import reverse, bold, normal

class Scheme(Default):
    def use(self, context):
        # Fetch the default colors and attributes from ranger's base theme
        fg, bg, attr = super().use(context)

        # Catch all selected items across all columns
        if context.in_browser and context.selected:
            if context.main_column:
                # 1. The active item under your cursor in the middle pane
                attr &= ~reverse  # Remove background highlight
                attr |= bold      # Make the text bold
                fg = 11           # Bright Yellow
            else:
                # 2. The selected items in the left (parent) and right (preview) columns
                attr &= ~reverse  # Strip the background highlight so they stay flat/transparent
                # Optional: uncomment the line below if you want to force them to plain normal text
                # attr = normal

        return fg, bg, attr
