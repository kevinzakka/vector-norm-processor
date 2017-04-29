## Vector Norm List Processor
 
<p align="center">
 <img src="./img/vnlp.PNG" width="400px">
</p>

This is a **Verilog** implementation of a Vector Norm List Processor. The VNLP processor computes the L2 norm of an n-dimensional complex vector of the form v = x + iy. Recall that the L2 norm of a multidimensional vector is defined as follows:

<p align="center">
 <img src="./img/eq.PNG" width="150px">
</p>

## Details

The **x** and **y** values of the vector are stored in memory in the form of a doubly linked-list data structure shown below.

<p align="center">
 <img src="./img/linked_list.PNG" width="600px">
</p>

Each node in the list contains 4 words: the first two contain the next and previous pointers and the last two contain the x and y values. The first node in the list is stored at address 0 in memory, while the last node is stored at address A. There are 512 words in memory. Hence memory can contain at most 512/4 = 128 nodes, and therefore the maximum length of vectors supported in this design is 128. Also note that the maximum value of address A is 508.

## Implementation

There are 4 main components that define the architecture of this design:

- **VNLP**: the top level block
- **Memory**: implements the memory block
- **Datapath**: implements the datapath
- **Control**: implements the controller


