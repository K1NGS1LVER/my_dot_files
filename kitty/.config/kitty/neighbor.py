from kitty.boss import Boss

def main(args):
    pass

def handle_result(args, result, target_window_id, boss):
    direction = args[1]
    boss.active_tab.neighboring_window(direction)
