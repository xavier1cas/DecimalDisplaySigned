`ifndef __UTILITIES__
`define __UTILITIES__

// // Utility function to compute log2 ceiling
// function integer clog2;
//     input integer value;
//     integer i;
//     begin
//         clog2 = 0;
//         for (i = value - 1; i > 0; i = i >> 1)
//             // Start with i = value - 1 (e.g. if value is 456, i = 455)
//             // While i > 0, divide it by 2 (i = i >> 1 shifts right by 1 bit).
//             // Every time we divide i, we increment clog2 by 1.
//             clog2 = clog2 + 1;
//     end
// endfunction

`endif // __UTILITIES__