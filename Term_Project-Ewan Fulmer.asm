.data
null_piece:	.asciiz	"#"
white_piece:	.asciiz	"O"
black_piece:	.asciiz	"X"
tab:			.asciiz	"\t"
new_line:		.asciiz	"\n"
numbers:		.asciiz	"1	2	3\n"
choose_column_message:	.asciiz	"Choose a column: "
column_full_message:	.asciiz	"\nColumn is full! Choose another!\n\n"
invalid_input_message:	.asciiz	"\nInvalid input! Must be 1, 2, or 3\n\n"
welcome_message:		.asciiz	"Three In a Line Game\nMake a move by selecting a column 1, 2 or 3\n"
user_won_message:		.asciiz	"\nYou win!\n"
user_lost_message:		.asciiz	"\nYou lost!\n"
board_value:	.word	0,0,0,
					0,0,0,
					0,0,0,
					0,0,0,
					0,0,0,
					0,0,0

.text
la	$a0, welcome_message
li	$v0, 4
syscall

# $s0 holds the address of the first index of the array
la	$s0, board_value
# $a0 also holds the numeric values of the board
add $a0, $zero, $s0
# jump to display_board function
jal	display_board


# Subroutine for user turn to make a move
user_turn:
# Prompt for column number to drop piece
la	$a0, choose_column_message
li	$v0, 4
syscall

# Read in number from user must be 1, 2 or 3
li	$v0, 5
syscall

add	$a0, $zero, $v0

# Subroutine for inserting a dot based on user input, branched based on input 1, 2 or 3
insert_dot_user:
add	$s1,	$zero, $a0

beq	$s1, 1, if_1_user
beq	$s1, 2, if_2_user
beq	$s1, 3, if_3_user

j	invalid_input_user

# t1 is counter for loop that will iterate a maximum of 6 times, as this is the height of the board
if_1_user:
add	$t1, $zero, 1
# initialize s1 with the address of the bottom most area in column 1 of the board
la	$s1, board_value
addi	$s1, $s1, 60
#Loops through and decrements through the 1st column to find an empty spot
if_1_loop_user:
lw	$s2, ($s1)

add	$a0, $zero, $s1
beq	$s2, 0, empty_found_1_user

subi	$s1, $s1, 12
addi	$t1, $t1, 1
bge	$t1, 7, column_full_user
j if_1_loop_user

empty_found_1_user:
add	$s1, $zero, $a0
add	$t2, $zero, 1
sw	$t2,	($s1)
j	end_of_turn_user

# Much the same as if_1 but for column 2
if_2_user:
add	$t1, $zero, 1
# initialize s1 with the address of the bottom most area in column 1 of the board
la	$s1, board_value
addi	$s1, $s1, 64
if_2_loop_user:
lw	$s2, ($s1)

add	$a0, $zero, $s1
beq	$s2, 0, empty_found_2_user

subi	$s1, $s1, 12
addi	$t1, $t1, 1
bge	$t1, 7, column_full_user
j if_2_loop_user

empty_found_2_user:
add	$s1, $zero, $a0
add	$t2, $zero, 1
sw	$t2,	($s1)
j	end_of_turn_user

#Much the same as if_1 and if_2 but for column 3
if_3_user:
add	$t1, $zero, 1
# initialize s1 with the address of the bottom most area in column 1 of the board
la	$s1, board_value
addi	$s1, $s1, 68
if_3_loop_user:
lw	$s2, ($s1)

add	$a0, $zero, $s1
beq	$s2, 0, empty_found_3_user

subi	$s1, $s1, 12
addi	$t1, $t1, 1
bge	$t1, 7, column_full_user
j if_3_loop_user

empty_found_3_user:
add	$s1, $zero, $a0
add	$t2, $zero, 1
sw	$t2,	($s1)
j	end_of_turn_user

end_of_turn_user:
j	check_win_user

# Subroutine for computer  turn to make a move
computer_turn:
# Get a random number for computer move between 0 and 2
li	$v0, 42
la	$a1, 3
syscall

addi	$a0, $a0, 1

# Subroutine for inserting a dot based on user input, branched based on input 1, 2 or 3
insert_dot_computer:
add	$s1,	$zero, $a0

beq	$s1, 1, if_1_computer
beq	$s1, 2, if_2_computer
beq	$s1, 3, if_3_computer

# t1 is counter for loop that will iterate a maximum of 6 times, as this is the height of the board
if_1_computer:
add	$t1, $zero, 1
# initialize s1 with the address of the bottom most area in column 1 of the board
la	$s1, board_value
addi	$s1, $s1, 60
#Loops through and decrements through the 1st column to find an empty spot
if_1_loop_computer:
lw	$s2, ($s1)

add	$a0, $zero, $s1
beq	$s2, 0, empty_found_1_computer

subi	$s1, $s1, 12
addi	$t1, $t1, 1
bge	$t1, 7, column_full_computer
j if_1_loop_computer

empty_found_1_computer:
add	$s1, $zero, $a0
add	$t2, $zero, 2
sw	$t2,	($s1)
j	end_of_turn_computer

# Much the same as if_1 but for column 2
if_2_computer:
add	$t1, $zero, 1
# initialize s1 with the address of the bottom most area in column 1 of the board
la	$s1, board_value
addi	$s1, $s1, 64
if_2_loop_computer:
lw	$s2, ($s1)

add	$a0, $zero, $s1
beq	$s2, 0, empty_found_2_computer

subi	$s1, $s1, 12
addi	$t1, $t1, 1
bge	$t1, 7, column_full_computer
j if_2_loop_computer

empty_found_2_computer:
add	$s1, $zero, $a0
add	$t2, $zero, 2
sw	$t2,	($s1)
j	end_of_turn_computer

#Much the same as if_1 and if_2 but for column 3
if_3_computer:
add	$t1, $zero, 1
# initialize s1 with the address of the bottom most area in column 1 of the board
la	$s1, board_value
addi	$s1, $s1, 68
if_3_loop_computer:
lw	$s2, ($s1)

add	$a0, $zero, $s1
beq	$s2, 0, empty_found_3_computer

subi	$s1, $s1, 12
addi	$t1, $t1, 1
bge	$t1, 7, column_full_computer
j if_3_loop_computer

empty_found_3_computer:
add	$s1, $zero, $a0
add	$t2, $zero, 2
sw	$t2,	($s1)
j	end_of_turn_computer

end_of_turn_computer:
j	check_win_computer
end_of_turn_both:
la	$a0, board_value
jal	display_board
j	user_turn

# Subroutine for displaying the board
# s1: address of element in array, incremented after each loop iteration
# s2: value of array element at index with address in s1
# t0: counter for loop, starts with 1 with a max value of 18, corresponds to each element in board
#a0: holds arguments for subroutines to be called
display_board:
# $s1 holds the 0 index of the board_numbers array initially
add $s1, $a0 ,$zero

la	$a0, new_line
li	$v0, 4
syscall

# Store return address from jal as jal will be used again
addi	$sp, $sp, -4
sw	$ra, 0($sp)
# To be used as a counter for the loop
add $t0, $zero, 1
display_board_for_loop:
# add to the $s1 the offset value of $t0
lw	$s2,	($s1)

# pass in s2 which has the numeric value as the value and call the display_piece function
add	$a0, $zero, $s2
jal	display_piece

add $a0, $zero, $t0
jal	tab_or_new_line


# Increment the counter and address
add $t0, $t0, 1
add	$s1, $s1, 4

# If the counter is 19 or higher jump to the end
bge $t0, 19, end_display_loop

# Jump back to the top of the loop
j display_board_for_loop

# s3: holds the numeric value of the piece, read in from a0
display_piece:
# Set $s3 to the parameter passed which is the numeric value of the piece
add $s3, $a0, $zero

# Branch and display based on value of piece
beq	$s3, 0, null_piece_display
beq	$s3, 1, white_piece_display
beq	$s3,	2, black_piece_display

null_piece_display:
la	$a0, null_piece
li	$v0, 4
syscall
jr	$ra

white_piece_display:
la	$a0,	white_piece
li	$v0, 4
syscall
jr	$ra

black_piece_display:
la	$a0, black_piece
li	$v0, 4
syscall
jr	$ra

# s3 holds the mod value of the counter divided by 3, if the mod value is 0 then there is a new line
# if not then it will be a tab
tab_or_new_line:
add	$s3, $zero, $a0
add $t1, $zero, 3
div  $s3, $t1
mfhi	$s3

beq $s3, $zero, output_new_line

output_tab:
la	$a0, tab
li	$v0, 4
syscall
jr	$ra

output_new_line:
la	$a0, new_line
li	$v0, 4
syscall
jr	$ra

# Goes back to after display function was called
end_display_loop:
la	$a0, numbers
li	$v0, 4
syscall

lw	$ra,	0($sp)
addi	$sp, $sp, 4
jr	$ra

# If column is full display error message and jumpt back to user turn subroutine
column_full_user:
la	$a0, column_full_message
li	$v0, 4
syscall

j	user_turn

# If the computer choice is a full column then jump back to computer turn subroutine
column_full_computer:
j	computer_turn

invalid_input_user:
la	$a0, invalid_input_message
li	$v0, 4
syscall
j	user_turn

# Subroutine to check for user win
check_win_user:
la	$s3, board_value
addi	$s3, $s3, 60

# Subroutine checks whether horizontal winning condition by looping through each line and seeing if
# there are 3 pieces in a row
check_win_horizontal_user:
add	$t2, $zero, $zero
horizontal_outer_loop_user:
add	$t0, $zero, $zero
add	$t1, $zero, $zero
horizontal_inner_loop_user:
lw	$s4, ($s3)
beq	$s4, 1, horizontal_add_1_user
addi	$t0, $t0, 1
beq	$t0, 3, end_horizontal_inner_loop_user
addi	$s3, $s3, 4
j	horizontal_inner_loop_user

horizontal_add_1_user:
addi $t1, $t1, 1
addi	$t0, $t0, 1
beq	$t0, 3, end_horizontal_inner_loop_user
addi	$s3, $s3, 4
j	horizontal_inner_loop_user

end_horizontal_inner_loop_user:
addi	$s3, $s3, -20
addi	$t2, $t2, 1
beq	$t1, 3, user_won
beq	$t2, 6, end_horizontal_outer_loop_user
j	horizontal_outer_loop_user

end_horizontal_outer_loop_user:


# Subroutine for checking whether the vertical condition is met for a win, checks each possible 3 piece
# arrangement vertically and checks if there are 3 in a row
check_win_vertical_user:
# $s0: Pointer to board pieces
la	$s0, board_value
# Start at a1 position
addi	$s0, $s0, 60
# Counter for outer loop (iterates 12 times)
add	$t0, $zero, $zero
vertical_outer_loop_user:
addi	$t0, $t0, 1
# Counter for inner loop (iterates 3 times)
add	$t1, $zero, $zero
# Counter for number of user pieces in a vertical line(maximum 3 results in a win)
add	$t2, $zero, $zero
vertical_inner_loop_user:
addi	$t1, $t1, 1
lw	$s1, ($s0)
jal	vertical_add_1_user
beq	$t1, 3, end_vertical_inner_loop_user
add $s0,	$s0, -12
j	vertical_inner_loop_user

end_vertical_inner_loop_user:
jal	move_over_column
beq	$t2, 3, user_won
beq	$t0, 12, end_vertical_outer_loop_user
j	vertical_outer_loop_user

end_vertical_outer_loop_user:

# subroutine that checks if the user meets diagonal winning conditions
check_diagonal_user:
# $s0: Pointer to board pieces
la	$s0, board_value
# Start at a1 position
addi	$s0, $s0, 60

# Counter for outer loop
add	$t0, $zero, $zero
diagonal_outer_loop1_user:
# Iterate outer loop counter
addi	$t0, $t0, 1
# inner loop counter
add	$t1, $zero, $zero
# counter for number of pieces in a diagonal line
add	$t2, $zero, $zero
diagonal_inner_loop1_user:
addi	$t1, $t1, 1
lw	$s1, ($s0)
jal	diagonal_add_1_user
beq	$t1, 3, end_diagonal_inner_loop1_user
add	$s0, $s0, -8
j	diagonal_inner_loop1_user

end_diagonal_inner_loop1_user:
beq	$t2, 3, user_won
beq	$t0, 4, end_diagonal_outer_loop1_user
addi	$s0, $s0, 4
j	diagonal_outer_loop1_user

end_diagonal_outer_loop1_user:

# $s0: Pointer to board pieces
la	$s0, board_value
# Start at a1 position
addi	$s0, $s0, 68

# Counter for outer loop
add	$t0, $zero, $zero
diagonal_outer_loop2_user:
# Iterate outer loop counter
addi	$t0, $t0, 1
# inner loop counter
add	$t1, $zero, $zero
# counter for number of pieces in a diagonal line
add	$t2, $zero, $zero
diagonal_inner_loop2_user:
addi	$t1, $t1, 1
lw	$s1, ($s0)
jal	diagonal_add_1_user
beq	$t1, 3, end_diagonal_inner_loop2_user
add	$s0, $s0, -16
j	diagonal_inner_loop2_user

end_diagonal_inner_loop2_user:
beq	$t2, 3, user_won
beq	$t0, 4, end_diagonal_outer_loop2_user
addi	$s0, $s0, 20
j	diagonal_outer_loop2_user

end_diagonal_outer_loop2_user:
j	computer_turn

diagonal_add_1_user:
bne	$s1, 1, no_user_piece_diagonal_user
addi	$t2, $t2, 1
jr	$ra

no_user_piece_diagonal_user:
jr	$ra

vertical_add_1_user:
bne	$s1, 1, no_user_piece_vertical_user
addi	$t2, $t2, 1
jr	$ra

no_user_piece_vertical_user:
jr	$ra

move_over_column:
beq	$t0, 4, top_of_column 
beq	$t0, 8, top_of_column
addi	$s0, $s0, 12
jr	$ra

top_of_column:
addi	$s0, $s0, 64
jr	$ra

check_win_computer:
la	$s3, board_value
addi	$s3, $s3, 60

check_win_horizontal_computer:
add	$t2, $zero, $zero
horizontal_outer_loop_computer:
add	$t0, $zero, $zero
add	$t1, $zero, $zero
horizontal_inner_loop_computer:
lw	$s4, ($s3)
beq	$s4, 2, horizontal_add_1_computer
addi	$t0, $t0, 1
beq	$t0, 3, end_horizontal_inner_loop_computer
addi	$s3, $s3, 4
j	horizontal_inner_loop_computer

horizontal_add_1_computer:
addi $t1, $t1, 1
addi	$t0, $t0, 1
beq	$t0, 3, end_horizontal_inner_loop_computer
addi	$s3, $s3, 4
j	horizontal_inner_loop_computer

end_horizontal_inner_loop_computer:
addi	$s3, $s3, -20
addi	$t2, $t2, 1
beq	$t1, 3, user_lost
beq	$t2, 6, end_horizontal_outer_loop_computer
j	horizontal_outer_loop_computer

end_horizontal_outer_loop_computer:

# Subroutine to check whether the computer meets winning conditions, much the same as the user 
# check win subroutine
check_win_vertical_computer:
# $s0: Pointer to board pieces
la	$s0, board_value
# Start at a1 position
addi	$s0, $s0, 60
# Counter for outer loop (iterates 12 times)
add	$t0, $zero, $zero
vertical_outer_loop_computer:
addi	$t0, $t0, 1
# Counter for inner loop (iterates 3 times)
add	$t1, $zero, $zero
# Counter for number of user pieces in a vertical line(maximum 3 results in a win)
add	$t2, $zero, $zero
vertical_inner_loop_computer:
addi	$t1, $t1, 1
lw	$s1, ($s0)
jal	vertical_add_1_computer
beq	$t1, 3, end_vertical_inner_loop_computer
add $s0,	$s0, -12
j	vertical_inner_loop_computer

end_vertical_inner_loop_computer:
jal	move_over_column_computer
beq	$t2, 3, user_lost
beq	$t0, 12, end_vertical_outer_loop_computer
j	vertical_outer_loop_computer

end_vertical_outer_loop_computer:

check_diagonal_computer:
# $s0: Pointer to board pieces
la	$s0, board_value
# Start at a1 position
addi	$s0, $s0, 60

# Counter for outer loop
add	$t0, $zero, $zero
diagonal_outer_loop1_computer:
# Iterate outer loop counter
addi	$t0, $t0, 1
# inner loop counter
add	$t1, $zero, $zero
# counter for number of pieces in a diagonal line
add	$t2, $zero, $zero
diagonal_inner_loop1_computer:
addi	$t1, $t1, 1
lw	$s1, ($s0)
jal	diagonal_add_1_computer
beq	$t1, 3, end_diagonal_inner_loop1_computer
add	$s0, $s0, -8
j	diagonal_inner_loop1_computer

end_diagonal_inner_loop1_computer:
beq	$t2, 3, user_won
beq	$t0, 4, end_diagonal_outer_loop1_computer
addi	$s0, $s0, 4
j	diagonal_outer_loop1_computer

end_diagonal_outer_loop1_computer:

# $s0: Pointer to board pieces
la	$s0, board_value
# Start at a1 position
addi	$s0, $s0, 68

# Counter for outer loop
add	$t0, $zero, $zero
diagonal_outer_loop2_computer:
# Iterate outer loop counter
addi	$t0, $t0, 1
# inner loop counter
add	$t1, $zero, $zero
# counter for number of pieces in a diagonal line
add	$t2, $zero, $zero
diagonal_inner_loop2_computer:
addi	$t1, $t1, 1
lw	$s1, ($s0)
jal	diagonal_add_1_computer
beq	$t1, 3, end_diagonal_inner_loop2_computer
add	$s0, $s0, -16
j	diagonal_inner_loop2_computer

end_diagonal_inner_loop2_computer:
beq	$t2, 3, user_won
beq	$t0, 4, end_diagonal_outer_loop2_computer
addi	$s0, $s0, 20
j	diagonal_outer_loop2_computer

end_diagonal_outer_loop2_computer:
j	end_of_turn_both

diagonal_add_1_computer:
bne	$s1, 2, no_computer_piece_diagonal
addi	$t2, $t2, 1
jr	$ra

no_computer_piece_diagonal:
jr	$ra

vertical_add_1_computer:
bne	$s1, 2, no_computer_piece_vertical
addi	$t2, $t2, 1
jr	$ra

no_computer_piece_vertical:
jr	$ra

move_over_column_computer:
beq	$t0, 4, top_of_column_computer 
beq	$t0, 8, top_of_column_computer
addi	$s0, $s0, 12
jr	$ra

top_of_column_computer:
addi	$s0, $s0, 64
jr	$ra

# Displays that the user won
user_won:
la	$a0, board_value
jal	display_board

la	$a0, user_won_message
li	$v0, 4
syscall

j end

# Displays that the user lost
user_lost:
la	$a0, board_value
jal	display_board

la	$a0, user_lost_message
li	$v0, 4
syscall


end:
