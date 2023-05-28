import csv
from tkinter import Tk, Button, Text, filedialog

def convert_to_markdown(csv_file):
    with open(csv_file, 'r') as file:
        reader = csv.reader(file)
        table = []
        for row in reader:
            table.append('|'.join(row))
        return '\n'.join(table)

def select_csv_file():
    file_path = filedialog.askopenfilename(filetypes=[('CSV Files', '*.csv')])
    if file_path:
        markdown_table = convert_to_markdown(file_path)
        text_box.delete(1.0, 'end')
        text_box.insert('end', markdown_table)

# Create the GUI window
window = Tk()
window.title("CSV to Markdown Table Converter")

# Create the button
button = Button(window, text="Select CSV File", command=select_csv_file)
button.pack()

# Create the textbox
text_box = Text(window)
text_box.pack()

# Start the GUI event loop
window.mainloop()
