# Python program to
# Fix the format the .sdc to work with prime time
  
  
# Using readline()
file2 = open('design_format.sdc', 'w')
file1 = open('design.sdc', 'r')
count = 0
  
while True:
    count += 1
  
    # Get next line from file
    line = file1.readline()
     
    #if append is in line, this is improper syntax for primetime
    if "append" in line:
        print(line)

    else:
        file2.writelines(line)


    # if line is empty
    # end of file is reached
    if not line:
        break
  
  
file1.close()
file2.close()
