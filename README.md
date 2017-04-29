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

Each word in memory is 24 bits wide. These bits are divided into 3 fields: the sign, the exponent and the mantissa. However note that since we are squaring the components of the vector when performing our calculations, the sign bit field can be ignored (the square of a number is always positive).

<p align="center">
 <img src="./img/word.PNG" width="400px">
</p>

## File Hierarchy

    data
    ├── YOUR_DATASET_NAME
    │   ├── A
    │   |   ├── xxx.jpg (name doesn't matter)
    │   |   ├── yyy.jpg
    │   |   └── ...
    │   └── B
    │       ├── zzz.jpg
    │       ├── www.jpg
    │       └── ...
    └── download_dataset.sh

## Implementation

There are 4 main components that define the architecture of this design:

- **VNLP**: the top level block
- **Memory**: implements the memory block
- **Datapath**: implements the datapath
- **Control**: implements the controller

The **Datapath** consists of registers, control signals, multiplexors and a floating point unit capable of performing multiplication (squaring) and addition on its operands. 

Meanwhile, the **Processor** is in charge of the timing of all the activity of datapath. It is essentially an FSM with 4 states:

- **S_idle**: state entered after start is asserted. Registers are reset.
- **S_calc**: Perform the L2 norm calculation on the currently fetched vector. 
- **S_fetch**: fetch the address of the next node in the list using the next node field.
- **S_done**: state entered when the whole list has been traversed and the final length and norm have been calculated.

Note that the current design of the datapath is not fully optimized as a whole clock cycle is being wasted to fetch the address of the next node in the list. An optimized version is in progress...

## Scripts

I've included a few python scripts which help with reading the output of the verilog test bench and converting from the 24 bit floating point representation to a decimal number.

## Results
