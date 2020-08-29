# textable
Matlab function to export a matrix as a tex table

Exporting Matlab matrices as tex tables can be a time consuming exercise. A common problem I faced was that even minor changes to the Matlab results required a lengthy adjustment procedure of the tex code. To save time, I created the function `textable.m` which aims to integrate the export procedure.

`textable.m` prints the matrix together with tabular tex commands into an external `.tex` file. This file can easily be used as an input to a larger tex document. Inevitably, the function needs to be adjusted to allow for specific details of the desired table. Once this structure is set up, any changes to the matrix export seamlessly as a tex table.

Have a look at the function as well as the pdf file for an illustration. Surely there are even better ways to do this - I'll be happy to include suggestions!
