board = [" " for i in range(9)]

def print_board():
    row_1 = "| {} | {} | {} |".format(board[0],board[1],board[2])
    row_2 = "| {} | {} | {} |".format(board[3],board[4],board[5])
    row_3 = "| {} | {} | {} |".format(board[6],board[7],board[8])

    print()
    print(row_1)
    print(row_2)
    print(row_3)
    print()

def player_move(icon):
    if icon == "X":
        number = 1
    elif icon == "O":
        number = 2
    print("Your turn player {}".format(number))
    #ask user to place their move
    choice = int(input("Enter your move (1-9): ").strip())
    if board[choice - 1] == " ":
        board[choice - 1] = icon # indexing starts from 0 
    else:
        print()
        print("That space is taken!")
def is_victory(icon):
    if(board[0] == icon and board[1] == icon and board[2] == icon)or\
      (board[3] == icon and board[4] == icon and board[5] == icon)or\
      (board[6] == icon and board[7] == icon and board[8] == icon)or\
      (board[0] == icon and board[3] == icon and board[6] == icon)or\
      (board[1] == icon and board[4] == icon and board[7] == icon)or\
      (board[2] == icon and board[5] == icon and board[8] == icon)or\
      (board[0] == icon and board[4] == icon and board[8] == icon)or\
      (board[2] == icon and board[4] == icon and board[6] == icon):
       return True
    else:
       return False
def is_draw():
    if " " not in board:
        return True
    else:
        return False
    

while True:    
    print_board()
    player_move("X")
    print_board()
    if is_victory("X"):
        print("X Wins! Confratulations!")
        break
        
    elif is_draw():
        print("Its a draw!")
        break
        
    player_move("O")
    if is_victory("O"):
        print_board()
        print("O Wins! Confratulations!")
        break
        
    elif is_draw():
        print("Its a draw!")
        break
       
   
    
