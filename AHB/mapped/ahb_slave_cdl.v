/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Fri Apr 28 12:48:14 2023
/////////////////////////////////////////////////////////////


module ahb_slave_cdl ( clk, n_rst, hsel, haddr, htrans, hsize, hwrite, hwdata, 
        hrdata, hresp, hready, rx_packet, rx_data_ready, rx_transfer_active, 
        rx_error, dmode, buffer_occupancy, rx_data, get_rx_data, store_tx_data, 
        tx_data, clear, tx_packet, tx_transfer_active, tx_error );
  input [3:0] haddr;
  input [1:0] htrans;
  input [1:0] hsize;
  input [31:0] hwdata;
  output [31:0] hrdata;
  input [3:0] rx_packet;
  input [6:0] buffer_occupancy;
  input [7:0] rx_data;
  output [7:0] tx_data;
  output [3:0] tx_packet;
  input clk, n_rst, hsel, hwrite, rx_data_ready, rx_transfer_active, rx_error,
         tx_transfer_active, tx_error;
  output hresp, hready, dmode, get_rx_data, store_tx_data, clear;
  wire   \slavedata[13][7] , \slavedata[13][6] , \slavedata[13][5] ,
         \slavedata[13][4] , \slavedata[13][3] , \slavedata[13][2] ,
         \slavedata[13][1] , \slavedata[12][7] , \slavedata[12][6] ,
         \slavedata[12][5] , \slavedata[12][4] , \slavedata[12][3] ,
         \slavedata[12][2] , \slavedata[12][1] , \slavedata[12][0] ,
         \slavedata[11][7] , \slavedata[11][6] , \slavedata[11][5] ,
         \slavedata[11][4] , \slavedata[11][3] , \slavedata[11][2] ,
         \slavedata[11][1] , \slavedata[11][0] , \slavedata[10][7] ,
         \slavedata[10][6] , \slavedata[10][5] , \slavedata[10][4] ,
         \slavedata[10][3] , \slavedata[10][2] , \slavedata[10][1] ,
         \slavedata[10][0] , \slavedata[9][0] , \slavedata[8][6] ,
         \slavedata[8][5] , \slavedata[8][4] , \slavedata[8][3] ,
         \slavedata[8][2] , \slavedata[8][1] , \slavedata[8][0] ,
         \slavedata[7][0] , \slavedata[6][0] , \slavedata[5][1] ,
         \slavedata[5][0] , \slavedata[4][4] , \slavedata[4][3] ,
         \slavedata[4][2] , \slavedata[4][1] , \slavedata[4][0] ,
         \slavedata[3][7] , \slavedata[3][6] , \slavedata[3][5] ,
         \slavedata[3][4] , \slavedata[3][3] , \slavedata[3][2] ,
         \slavedata[3][1] , \slavedata[3][0] , \slavedata[2][7] ,
         \slavedata[2][6] , \slavedata[2][5] , \slavedata[2][4] ,
         \slavedata[2][3] , \slavedata[2][2] , \slavedata[2][1] ,
         \slavedata[2][0] , \slavedata[1][7] , \slavedata[1][6] ,
         \slavedata[1][5] , \slavedata[1][4] , \slavedata[1][3] ,
         \slavedata[1][2] , \slavedata[1][1] , \slavedata[1][0] ,
         \slavedata[0][7] , \slavedata[0][6] , \slavedata[0][5] ,
         \slavedata[0][4] , \slavedata[0][3] , \slavedata[0][2] ,
         \slavedata[0][1] , \slavedata[0][0] , write, \next_slavedata[13][7] ,
         \next_slavedata[13][6] , \next_slavedata[13][5] ,
         \next_slavedata[13][4] , \next_slavedata[13][3] ,
         \next_slavedata[13][2] , \next_slavedata[13][1] ,
         \next_slavedata[13][0] , \next_slavedata[12][7] ,
         \next_slavedata[12][6] , \next_slavedata[12][5] ,
         \next_slavedata[12][4] , \next_slavedata[12][3] ,
         \next_slavedata[12][2] , \next_slavedata[12][1] ,
         \next_slavedata[12][0] , \next_slavedata[11][7] ,
         \next_slavedata[11][6] , \next_slavedata[11][5] ,
         \next_slavedata[11][4] , \next_slavedata[11][3] ,
         \next_slavedata[11][2] , \next_slavedata[11][1] ,
         \next_slavedata[11][0] , \next_slavedata[10][7] ,
         \next_slavedata[10][6] , \next_slavedata[10][5] ,
         \next_slavedata[10][4] , \next_slavedata[10][3] ,
         \next_slavedata[10][2] , \next_slavedata[10][1] ,
         \next_slavedata[10][0] , \next_slavedata[9][0] ,
         \next_slavedata[8][6] , \next_slavedata[8][5] ,
         \next_slavedata[8][4] , \next_slavedata[8][3] ,
         \next_slavedata[8][2] , \next_slavedata[8][1] ,
         \next_slavedata[8][0] , \next_slavedata[7][0] ,
         \next_slavedata[6][0] , \next_slavedata[5][1] ,
         \next_slavedata[5][0] , \next_slavedata[4][4] ,
         \next_slavedata[4][3] , \next_slavedata[4][2] ,
         \next_slavedata[4][1] , \next_slavedata[4][0] ,
         \next_slavedata[3][7] , \next_slavedata[3][6] ,
         \next_slavedata[3][5] , \next_slavedata[3][4] ,
         \next_slavedata[3][3] , \next_slavedata[3][2] ,
         \next_slavedata[3][1] , \next_slavedata[3][0] ,
         \next_slavedata[2][7] , \next_slavedata[2][6] ,
         \next_slavedata[2][5] , \next_slavedata[2][4] ,
         \next_slavedata[2][3] , \next_slavedata[2][2] ,
         \next_slavedata[2][1] , \next_slavedata[2][0] ,
         \next_slavedata[1][7] , \next_slavedata[1][6] ,
         \next_slavedata[1][5] , \next_slavedata[1][4] ,
         \next_slavedata[1][3] , \next_slavedata[1][2] ,
         \next_slavedata[1][1] , \next_slavedata[1][0] ,
         \next_slavedata[0][7] , \next_slavedata[0][6] ,
         \next_slavedata[0][5] , \next_slavedata[0][4] ,
         \next_slavedata[0][3] , \next_slavedata[0][2] ,
         \next_slavedata[0][1] , \next_slavedata[0][0] , \next_address[1] ,
         next_hwrite, N1337, N1338, N1339, N1490, N1534, N1535, N1536, N1537,
         N1538, N1539, N1540, N1541, N1556, N1557, N1558, N1559, N1560, N1561,
         N1562, N1563, next_hsize, n1008, n1087, n1088, n1089, n1090, n2148,
         n2149, n2150, n2151, n2152, n2153, n2154, n2155, n2156, n2157, n2158,
         n2159, n2160, n2161, n2162, n2163, n2164, n2165, n2166, n2167, n2168,
         n2169, n2170, n2171, n2172, n2173, n2174, n2175, n2176, n2177, n2178,
         n2179, n2180, n2181, n2182, n2183, n2184, n2185, n2186, n2187, n2188,
         n2189, n2190, n2191, n2192, n2193, n2194, n2195, n2196, n2197, n2198,
         n2199, n2200, n2201, n2202, n2203, n2204, n2205, n2206, n2207, n2208,
         n2209, n2210, n2211, n2212, n2213, n2214, n2215, n2216, n2217, n2218,
         n2219, n2220, n2221, n2222, n2223, n2224, n2225, n2226, n2227, n2228,
         n2229, n2230, n2231, n2232, n2233, n2234, n2235, n2236, n2237, n2238,
         n2239, n2240, n2241, n2242, n2243, n2244, n2245, n2246, n2247, n2248,
         n2249, n2250, n2251, n2252, n2253, n2254, n2255, n2256, n2257, n2258,
         n2259, n2260, n2261, n2262, n2263, n2264, n2265, n2266, n2267, n2268,
         n2269, n2270, n2271, n2272, n2273, n2274, n2275, n2276, n2277, n2278,
         n2279, n2280, n2281, n2282, n2283, n2284, n2285, n2286, n2287, n2288,
         n2289, n2290, n2291, n2292, n2293, n2294, n2295, n2296, n2297, n2298,
         n2299, n2300, n2301, n2302, n2303, n2304, n2305, n2306, n2307, n2308,
         n2309, n2310, n2311, n2312, n2313, n2314, n2315, n2316, n2317, n2318,
         n2319, n2320, n2321, n2322, n2323, n2324, n2325, n2326, n2327, n2328,
         n2329, n2330, n2331, n2332, n2333, n2334, n2335, n2336, n2337, n2338,
         n2339, n2340, n2341, n2342, n2343, n2344, n2345, n2346, n2347, n2348,
         n2349, n2350, n2351, n2352, n2353, n2354, n2355, n2356, n2357, n2358,
         n2359, n2360, n2361, n2362, n2363, n2364, n2365, n2366, n2367, n2368,
         n2369, n2370, n2371, n2372, n2373, n2374, n2375, n2376, n2377, n2378,
         n2379, n2380, n2381, n2382, n2383, n2384, n2385, n2386, n2387, n2388,
         n2389, n2390, n2391, n2392, n2393, n2394, n2395, n2396, n2397, n2398,
         n2399, n2400, n2401, n2402, n2403, n2404, n2405, n2406, n2407, n2408,
         n2409, n2410, n2411, n2412, n2413, n2414, n2415, n2416, n2417, n2418,
         n2419, n2420, n2421, n2422, n2423, n2424, n2425, n2426, n2427, n2428,
         n2429, n2430, n2431, n2432, n2433, n2434, n2435, n2436, n2437, n2438,
         n2439, n2440, n2441, n2442, n2443, n2444, n2445, n2446, n2447, n2448,
         n2449, n2450, n2451, n2452, n2453, n2454, n2455, n2456, n2457, n2458,
         n2459, n2460, n2461, n2462, n2463, n2464, n2465, n2466, n2467, n2468,
         n2469, n2470, n2471, n2472, n2473, n2474, n2475, n2476, n2477, n2478,
         n2479, n2480, n2481, n2482, n2483, n2484, n2485, n2486, n2487, n2488,
         n2489, n2490, n2491, n2492, n2493, n2494, n2495, n2496, n2497, n2498,
         n2499, n2500, n2501, n2502, n2503, n2504, n2505, n2506, n2507, n2508,
         n2509, n2510, n2511, n2512, n2513, n2514, n2515, n2516, n2517, n2518,
         n2519, n2520, n2521, n2522, n2523, n2524, n2525, n2526, n2527, n2528,
         n2529, n2530, n2531, n2532, n2533, n2534, n2535, n2536, n2537, n2538,
         n2539, n2540, n2541, n2542, n2543, n2544, n2545, n2546, n2547, n2548,
         n2549, n2550, n2551, n2552, n2553, n2554, n2555, n2556, n2557, n2558,
         n2559, n2560, n2561, n2562, n2563, n2564, n2565, n2566, n2567, n2568,
         n2569, n2570, n2571, n2572, n2573, n2574, n2575, n2576, n2577, n2578,
         n2579, n2580, n2581, n2582, n2583, n2584, n2585, n2586, n2587, n2588,
         n2589, n2590, n2591, n2592, n2593, n2594, n2595, n2596, n2597, n2598,
         n2599, n2600, n2601, n2602, n2603, n2604, n2605, n2606, n2607, n2608,
         n2609, n2610, n2611, n2612, n2613, n2614, n2615, n2616, n2617, n2618,
         n2619, n2620, n2621, n2622, n2623, n2624, n2625, n2626, n2627, n2628,
         n2629, n2630, n2631, n2632, n2633, n2634, n2635, n2637, n2638, n2639,
         n2640, n2641, n2642, n2643, n2644, n2645, n2646, n2647, n2649, n2650,
         n2651, n2652, n2653, n2654, n2655, n2656, n2658, n2659, n2660, n2661,
         n2662, n2663, n2665, n2666, n2667, n2668, n2669, n2670, n2672, n2673,
         n2674, n2675, n2676, n2677, n2678, n2680, n2681, n2682, n2683, n2684,
         n2685, n2686, n2688, n2689, n2690, n2691, n2692, n2693, n2694, n2695,
         n2696, n2697, n2698, n2699, n2700, n2701, n2702, n2703, n2704, n2705,
         n2706, n2707, n2708, n2709, n2710, n2711, n2712, n2713, n2714, n2715,
         n2716, n2717, n2718, n2719, n2720, n2721, n2722, n2723, n2724, n2725,
         n2726, n2727, n2728, n2729, n2730, n2731, n2732, n2733, n2734, n2735,
         n2736, n2737, n2738, n2739, n2740, n2741, n2742, n2743, n2744, n2745,
         n2746, n2747, n2748, n2749, n2750, n2751, n2752, n2753, n2754, n2755,
         n2756, n2757, n2758, n2759, n2760, n2761, n2762, n2763, n2764, n2765,
         n2766, n2767, n2768, n2769, n2770, n2771, n2772, n2773, n2774, n2775,
         n2776, n2777, n2778, n2779, n2780, n2781, n2782, n2783, n2784, n2785,
         n2786, n2787, n2788, n2789, n2790, n2791, n2792, n2793, n2794, n2795,
         n2796, n2797, n2798, n2799, n2800, n2801, n2802, n2803, n2804, n2805,
         n2806, n2807, n2808, n2809, n2810, n2811, n2812, n2813, n2814, n2815,
         n2816, n2817, n2818, n2819, n2820, n2821, n2822, n2823, n2824, n2825,
         n2826, n2827, n2828, n2829, n2830, n2831, n2832, n2833, n2834, n2835,
         n2836;
  wire   [31:0] next_state_flush;
  wire   [31:0] flush_state;
  wire   [31:0] tx_state;
  wire   [31:0] next_data_state;
  wire   [31:0] data_state;
  wire   [3:0] addr;
  wire   [31:0] next_hrdata;
  wire   [3:0] next_haddr;
  assign store_tx_data = write;
  assign \next_slavedata[8][6]  = buffer_occupancy[6];
  assign \next_slavedata[8][5]  = buffer_occupancy[5];
  assign \next_slavedata[8][4]  = buffer_occupancy[4];
  assign \next_slavedata[8][3]  = buffer_occupancy[3];
  assign \next_slavedata[8][2]  = buffer_occupancy[2];
  assign \next_slavedata[8][1]  = buffer_occupancy[1];
  assign \next_slavedata[8][0]  = buffer_occupancy[0];
  assign \next_slavedata[7][0]  = tx_error;
  assign \next_slavedata[6][0]  = rx_error;
  assign \next_slavedata[5][1]  = tx_transfer_active;
  assign dmode = \next_slavedata[5][0] ;
  assign \next_slavedata[5][0]  = rx_transfer_active;
  assign \next_slavedata[4][0]  = rx_data_ready;

  DFFSR next_hsize_reg ( .D(hsize[0]), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        next_hsize) );
  DFFSR \tx_state_reg[0]  ( .D(n1090), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        tx_state[0]) );
  DFFSR \tx_state_reg[1]  ( .D(n1089), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        tx_state[1]) );
  DFFSR \flush_state_reg[0]  ( .D(next_state_flush[0]), .CLK(clk), .R(n_rst), 
        .S(1'b1), .Q(flush_state[0]) );
  DFFSR \flush_state_reg[1]  ( .D(next_state_flush[1]), .CLK(clk), .R(n_rst), 
        .S(1'b1), .Q(flush_state[1]) );
  DFFSR \addr_reg[3]  ( .D(n2835), .CLK(clk), .R(n_rst), .S(1'b1), .Q(addr[3])
         );
  DFFSR \addr_reg[2]  ( .D(n2834), .CLK(clk), .R(n_rst), .S(1'b1), .Q(addr[2])
         );
  DFFSR \addr_reg[1]  ( .D(\next_address[1] ), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(addr[1]) );
  DFFSR \addr_reg[0]  ( .D(N1490), .CLK(clk), .R(n_rst), .S(1'b1), .Q(addr[0])
         );
  DFFSR \next_haddr_reg[3]  ( .D(haddr[3]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(next_haddr[3]) );
  DFFSR \next_haddr_reg[2]  ( .D(haddr[2]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(next_haddr[2]) );
  DFFSR \next_haddr_reg[1]  ( .D(haddr[1]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(next_haddr[1]) );
  DFFSR \next_haddr_reg[0]  ( .D(haddr[0]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(next_haddr[0]) );
  DFFSR next_hwrite_reg ( .D(hwrite), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        next_hwrite) );
  DFFSR \slavedata_reg[11][0]  ( .D(\next_slavedata[11][0] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[11][0] ) );
  DFFSR \slavedata_reg[11][1]  ( .D(\next_slavedata[11][1] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[11][1] ) );
  DFFSR \data_state_reg[2]  ( .D(n1008), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        data_state[2]) );
  DFFSR read_reg ( .D(n1087), .CLK(clk), .R(n_rst), .S(1'b1), .Q(get_rx_data)
         );
  DFFSR \slavedata_reg[10][7]  ( .D(\next_slavedata[10][7] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[10][7] ) );
  DFFSR \slavedata_reg[10][6]  ( .D(\next_slavedata[10][6] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[10][6] ) );
  DFFSR \slavedata_reg[10][5]  ( .D(\next_slavedata[10][5] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[10][5] ) );
  DFFSR \slavedata_reg[10][4]  ( .D(\next_slavedata[10][4] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[10][4] ) );
  DFFSR \slavedata_reg[10][3]  ( .D(\next_slavedata[10][3] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[10][3] ) );
  DFFSR \slavedata_reg[10][2]  ( .D(\next_slavedata[10][2] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[10][2] ) );
  DFFSR \slavedata_reg[10][1]  ( .D(\next_slavedata[10][1] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[10][1] ) );
  DFFSR \slavedata_reg[10][0]  ( .D(\next_slavedata[10][0] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[10][0] ) );
  DFFSR \data_state_reg[1]  ( .D(next_data_state[1]), .CLK(clk), .R(n_rst), 
        .S(1'b1), .Q(data_state[1]) );
  DFFSR \data_state_reg[0]  ( .D(next_data_state[0]), .CLK(clk), .R(n_rst), 
        .S(1'b1), .Q(data_state[0]) );
  DFFSR \slavedata_reg[0][0]  ( .D(\next_slavedata[0][0] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[0][0] ) );
  DFFSR \slavedata_reg[0][1]  ( .D(\next_slavedata[0][1] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[0][1] ) );
  DFFSR \slavedata_reg[0][2]  ( .D(\next_slavedata[0][2] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[0][2] ) );
  DFFSR \slavedata_reg[0][3]  ( .D(\next_slavedata[0][3] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[0][3] ) );
  DFFSR \slavedata_reg[0][4]  ( .D(\next_slavedata[0][4] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[0][4] ) );
  DFFSR \slavedata_reg[0][5]  ( .D(\next_slavedata[0][5] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[0][5] ) );
  DFFSR \slavedata_reg[0][6]  ( .D(\next_slavedata[0][6] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[0][6] ) );
  DFFSR \slavedata_reg[0][7]  ( .D(\next_slavedata[0][7] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[0][7] ) );
  DFFSR write_reg ( .D(n1088), .CLK(clk), .R(n_rst), .S(1'b1), .Q(write) );
  DFFSR \slavedata_reg[11][2]  ( .D(\next_slavedata[11][2] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[11][2] ) );
  DFFSR \slavedata_reg[11][3]  ( .D(\next_slavedata[11][3] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[11][3] ) );
  DFFSR \slavedata_reg[11][4]  ( .D(\next_slavedata[11][4] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[11][4] ) );
  DFFSR \slavedata_reg[11][5]  ( .D(\next_slavedata[11][5] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[11][5] ) );
  DFFSR \slavedata_reg[11][6]  ( .D(\next_slavedata[11][6] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[11][6] ) );
  DFFSR \slavedata_reg[11][7]  ( .D(\next_slavedata[11][7] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[11][7] ) );
  DFFSR \slavedata_reg[12][0]  ( .D(\next_slavedata[12][0] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[12][0] ) );
  DFFSR \slavedata_reg[12][1]  ( .D(\next_slavedata[12][1] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[12][1] ) );
  DFFSR \slavedata_reg[12][2]  ( .D(\next_slavedata[12][2] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[12][2] ) );
  DFFSR \slavedata_reg[12][3]  ( .D(\next_slavedata[12][3] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[12][3] ) );
  DFFSR \slavedata_reg[12][4]  ( .D(\next_slavedata[12][4] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[12][4] ) );
  DFFSR \slavedata_reg[12][5]  ( .D(\next_slavedata[12][5] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[12][5] ) );
  DFFSR \slavedata_reg[12][6]  ( .D(\next_slavedata[12][6] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[12][6] ) );
  DFFSR \slavedata_reg[12][7]  ( .D(\next_slavedata[12][7] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[12][7] ) );
  DFFSR \slavedata_reg[13][0]  ( .D(\next_slavedata[13][0] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(clear) );
  DFFSR \slavedata_reg[13][1]  ( .D(\next_slavedata[13][1] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[13][1] ) );
  DFFSR \slavedata_reg[13][2]  ( .D(\next_slavedata[13][2] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[13][2] ) );
  DFFSR \slavedata_reg[13][3]  ( .D(\next_slavedata[13][3] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[13][3] ) );
  DFFSR \slavedata_reg[13][4]  ( .D(\next_slavedata[13][4] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[13][4] ) );
  DFFSR \slavedata_reg[13][5]  ( .D(\next_slavedata[13][5] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[13][5] ) );
  DFFSR \slavedata_reg[13][6]  ( .D(\next_slavedata[13][6] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[13][6] ) );
  DFFSR \slavedata_reg[13][7]  ( .D(\next_slavedata[13][7] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[13][7] ) );
  DFFSR \slavedata_reg[1][0]  ( .D(\next_slavedata[1][0] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[1][0] ) );
  DFFSR \slavedata_reg[1][1]  ( .D(\next_slavedata[1][1] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[1][1] ) );
  DFFSR \slavedata_reg[1][2]  ( .D(\next_slavedata[1][2] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[1][2] ) );
  DFFSR \slavedata_reg[1][3]  ( .D(\next_slavedata[1][3] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[1][3] ) );
  DFFSR \slavedata_reg[1][4]  ( .D(\next_slavedata[1][4] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[1][4] ) );
  DFFSR \slavedata_reg[1][5]  ( .D(\next_slavedata[1][5] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[1][5] ) );
  DFFSR \slavedata_reg[1][6]  ( .D(\next_slavedata[1][6] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[1][6] ) );
  DFFSR \slavedata_reg[1][7]  ( .D(\next_slavedata[1][7] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[1][7] ) );
  DFFSR \slavedata_reg[2][0]  ( .D(\next_slavedata[2][0] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[2][0] ) );
  DFFSR \slavedata_reg[2][1]  ( .D(\next_slavedata[2][1] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[2][1] ) );
  DFFSR \slavedata_reg[2][2]  ( .D(\next_slavedata[2][2] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[2][2] ) );
  DFFSR \slavedata_reg[2][3]  ( .D(\next_slavedata[2][3] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[2][3] ) );
  DFFSR \slavedata_reg[2][4]  ( .D(\next_slavedata[2][4] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[2][4] ) );
  DFFSR \slavedata_reg[2][5]  ( .D(\next_slavedata[2][5] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[2][5] ) );
  DFFSR \slavedata_reg[2][6]  ( .D(\next_slavedata[2][6] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[2][6] ) );
  DFFSR \slavedata_reg[2][7]  ( .D(\next_slavedata[2][7] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[2][7] ) );
  DFFSR \slavedata_reg[3][0]  ( .D(\next_slavedata[3][0] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[3][0] ) );
  DFFSR \slavedata_reg[3][1]  ( .D(\next_slavedata[3][1] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[3][1] ) );
  DFFSR \slavedata_reg[3][2]  ( .D(\next_slavedata[3][2] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[3][2] ) );
  DFFSR \slavedata_reg[3][3]  ( .D(\next_slavedata[3][3] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[3][3] ) );
  DFFSR \slavedata_reg[3][4]  ( .D(\next_slavedata[3][4] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[3][4] ) );
  DFFSR \slavedata_reg[3][5]  ( .D(\next_slavedata[3][5] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[3][5] ) );
  DFFSR \slavedata_reg[3][6]  ( .D(\next_slavedata[3][6] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[3][6] ) );
  DFFSR \slavedata_reg[3][7]  ( .D(\next_slavedata[3][7] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[3][7] ) );
  DFFSR \slavedata_reg[4][0]  ( .D(\next_slavedata[4][0] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[4][0] ) );
  DFFSR \slavedata_reg[4][1]  ( .D(\next_slavedata[4][1] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[4][1] ) );
  DFFSR \slavedata_reg[4][2]  ( .D(\next_slavedata[4][2] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[4][2] ) );
  DFFSR \slavedata_reg[4][3]  ( .D(\next_slavedata[4][3] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[4][3] ) );
  DFFSR \slavedata_reg[4][4]  ( .D(\next_slavedata[4][4] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[4][4] ) );
  DFFSR \slavedata_reg[5][0]  ( .D(\next_slavedata[5][0] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[5][0] ) );
  DFFSR \slavedata_reg[5][1]  ( .D(\next_slavedata[5][1] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[5][1] ) );
  DFFSR \slavedata_reg[6][0]  ( .D(\next_slavedata[6][0] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[6][0] ) );
  DFFSR \slavedata_reg[7][0]  ( .D(\next_slavedata[7][0] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[7][0] ) );
  DFFSR \slavedata_reg[8][0]  ( .D(\next_slavedata[8][0] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[8][0] ) );
  DFFSR \slavedata_reg[8][1]  ( .D(\next_slavedata[8][1] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[8][1] ) );
  DFFSR \slavedata_reg[8][2]  ( .D(\next_slavedata[8][2] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[8][2] ) );
  DFFSR \slavedata_reg[8][3]  ( .D(\next_slavedata[8][3] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[8][3] ) );
  DFFSR \slavedata_reg[8][4]  ( .D(\next_slavedata[8][4] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[8][4] ) );
  DFFSR \slavedata_reg[8][5]  ( .D(\next_slavedata[8][5] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[8][5] ) );
  DFFSR \slavedata_reg[8][6]  ( .D(\next_slavedata[8][6] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[8][6] ) );
  DFFSR \slavedata_reg[9][0]  ( .D(\next_slavedata[9][0] ), .CLK(clk), .R(
        n_rst), .S(1'b1), .Q(\slavedata[9][0] ) );
  DFFSR \hrdata_reg[0]  ( .D(next_hrdata[0]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(hrdata[0]) );
  DFFSR \hrdata_reg[1]  ( .D(next_hrdata[1]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(hrdata[1]) );
  DFFSR \hrdata_reg[2]  ( .D(next_hrdata[2]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(hrdata[2]) );
  DFFSR \hrdata_reg[3]  ( .D(next_hrdata[3]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(hrdata[3]) );
  DFFSR \hrdata_reg[4]  ( .D(next_hrdata[4]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(hrdata[4]) );
  DFFSR \hrdata_reg[5]  ( .D(next_hrdata[5]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(hrdata[5]) );
  DFFSR \hrdata_reg[6]  ( .D(next_hrdata[6]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(hrdata[6]) );
  DFFSR \hrdata_reg[7]  ( .D(next_hrdata[7]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(hrdata[7]) );
  DFFSR \hrdata_reg[23]  ( .D(next_hrdata[23]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(hrdata[23]) );
  DFFSR \hrdata_reg[22]  ( .D(next_hrdata[22]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(hrdata[22]) );
  DFFSR \hrdata_reg[21]  ( .D(next_hrdata[21]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(hrdata[21]) );
  DFFSR \hrdata_reg[20]  ( .D(next_hrdata[20]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(hrdata[20]) );
  DFFSR \hrdata_reg[19]  ( .D(next_hrdata[19]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(hrdata[19]) );
  DFFSR \hrdata_reg[18]  ( .D(next_hrdata[18]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(hrdata[18]) );
  DFFSR \hrdata_reg[17]  ( .D(next_hrdata[17]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(hrdata[17]) );
  DFFSR \hrdata_reg[16]  ( .D(next_hrdata[16]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(hrdata[16]) );
  DFFSR \hrdata_reg[31]  ( .D(next_hrdata[31]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(hrdata[31]) );
  DFFSR \hrdata_reg[30]  ( .D(next_hrdata[30]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(hrdata[30]) );
  DFFSR \hrdata_reg[29]  ( .D(next_hrdata[29]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(hrdata[29]) );
  DFFSR \hrdata_reg[28]  ( .D(next_hrdata[28]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(hrdata[28]) );
  DFFSR \hrdata_reg[27]  ( .D(next_hrdata[27]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(hrdata[27]) );
  DFFSR \hrdata_reg[26]  ( .D(next_hrdata[26]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(hrdata[26]) );
  DFFSR \hrdata_reg[25]  ( .D(next_hrdata[25]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(hrdata[25]) );
  DFFSR \hrdata_reg[24]  ( .D(next_hrdata[24]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(hrdata[24]) );
  DFFSR \hrdata_reg[9]  ( .D(next_hrdata[9]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(hrdata[9]) );
  DFFSR \hrdata_reg[8]  ( .D(next_hrdata[8]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(hrdata[8]) );
  DFFSR \hrdata_reg[15]  ( .D(next_hrdata[15]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(hrdata[15]) );
  DFFSR \hrdata_reg[14]  ( .D(next_hrdata[14]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(hrdata[14]) );
  DFFSR \hrdata_reg[13]  ( .D(next_hrdata[13]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(hrdata[13]) );
  DFFSR \hrdata_reg[12]  ( .D(next_hrdata[12]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(hrdata[12]) );
  DFFSR \hrdata_reg[11]  ( .D(next_hrdata[11]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(hrdata[11]) );
  DFFSR \hrdata_reg[10]  ( .D(next_hrdata[10]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(hrdata[10]) );
  NAND2X1 U2361 ( .A(n2300), .B(n2299), .Y(N1561) );
  NAND2X1 U2362 ( .A(n2310), .B(n2309), .Y(N1560) );
  NAND2X1 U2363 ( .A(n2320), .B(n2319), .Y(N1559) );
  NAND2X1 U2364 ( .A(n2330), .B(n2329), .Y(N1558) );
  NAND2X1 U2365 ( .A(n2340), .B(n2339), .Y(N1557) );
  NAND2X1 U2366 ( .A(n2358), .B(n2357), .Y(N1556) );
  NAND2X1 U2367 ( .A(n2188), .B(n2187), .Y(N1539) );
  NAND2X1 U2368 ( .A(n2198), .B(n2197), .Y(N1538) );
  NAND2X1 U2369 ( .A(n2208), .B(n2207), .Y(N1537) );
  NAND2X1 U2370 ( .A(n2218), .B(n2217), .Y(N1536) );
  NAND2X1 U2371 ( .A(n2228), .B(n2227), .Y(N1535) );
  NAND2X1 U2372 ( .A(n2246), .B(n2245), .Y(N1534) );
  OAI21X1 U2373 ( .A(n2686), .B(n2635), .C(1'b1), .Y(n2685) );
  OAI21X1 U2374 ( .A(n2678), .B(n2635), .C(1'b1), .Y(n2677) );
  OAI21X1 U2375 ( .A(n2545), .B(n2635), .C(1'b1), .Y(n2670) );
  OAI21X1 U2376 ( .A(n2542), .B(n2635), .C(1'b1), .Y(n2663) );
  OAI21X1 U2377 ( .A(n2539), .B(n2635), .C(1'b1), .Y(n2656) );
  OAI21X1 U2378 ( .A(n2536), .B(n2635), .C(1'b1), .Y(n2647) );
  OAI21X1 U2379 ( .A(n2530), .B(n2635), .C(1'b1), .Y(n2634) );
  NOR2X1 U2380 ( .A(n2232), .B(N1337), .Y(n2233) );
  NOR2X1 U2381 ( .A(n2344), .B(\next_address[1] ), .Y(n2345) );
  NAND2X1 U2382 ( .A(n2327), .B(n2747), .Y(n2330) );
  NAND2X1 U2383 ( .A(n2215), .B(n2254), .Y(n2218) );
  NAND2X1 U2384 ( .A(n2337), .B(n2747), .Y(n2340) );
  NAND2X1 U2385 ( .A(n2225), .B(n2254), .Y(n2228) );
  NAND2X1 U2386 ( .A(n2352), .B(n2747), .Y(n2358) );
  NAND2X1 U2387 ( .A(n2240), .B(n2254), .Y(n2246) );
  NAND2X1 U2388 ( .A(n2705), .B(\slavedata[10][1] ), .Y(n2733) );
  NAND2X1 U2389 ( .A(\slavedata[5][1] ), .B(n2341), .Y(n2290) );
  NAND2X1 U2390 ( .A(\slavedata[5][1] ), .B(n2229), .Y(n2178) );
  NAND2X1 U2391 ( .A(n2705), .B(\slavedata[10][2] ), .Y(n2728) );
  NAND2X1 U2392 ( .A(n2705), .B(\slavedata[10][3] ), .Y(n2723) );
  NAND2X1 U2393 ( .A(n2705), .B(\slavedata[10][4] ), .Y(n2716) );
  NAND2X1 U2394 ( .A(n2705), .B(\slavedata[10][5] ), .Y(n2711) );
  NAND2X1 U2395 ( .A(n2705), .B(\slavedata[10][6] ), .Y(n2706) );
  NAND2X1 U2396 ( .A(n2705), .B(\slavedata[10][7] ), .Y(n2699) );
  NAND2X1 U2397 ( .A(\slavedata[12][1] ), .B(n2353), .Y(n2287) );
  NAND2X1 U2398 ( .A(\slavedata[12][1] ), .B(n2241), .Y(n2175) );
  NAND2X1 U2399 ( .A(\slavedata[12][2] ), .B(n2353), .Y(n2298) );
  NAND2X1 U2400 ( .A(\slavedata[12][2] ), .B(n2241), .Y(n2186) );
  NAND2X1 U2401 ( .A(\slavedata[12][3] ), .B(n2353), .Y(n2308) );
  NAND2X1 U2402 ( .A(\slavedata[12][3] ), .B(n2241), .Y(n2196) );
  NAND2X1 U2403 ( .A(\slavedata[12][4] ), .B(n2353), .Y(n2318) );
  NAND2X1 U2404 ( .A(\slavedata[12][4] ), .B(n2241), .Y(n2206) );
  NAND2X1 U2405 ( .A(\slavedata[12][5] ), .B(n2353), .Y(n2328) );
  NAND2X1 U2406 ( .A(\slavedata[12][5] ), .B(n2241), .Y(n2216) );
  NAND2X1 U2407 ( .A(\slavedata[12][6] ), .B(n2353), .Y(n2338) );
  NAND2X1 U2408 ( .A(\slavedata[12][6] ), .B(n2241), .Y(n2226) );
  NAND2X1 U2409 ( .A(\slavedata[12][7] ), .B(n2353), .Y(n2355) );
  NAND2X1 U2410 ( .A(\slavedata[12][7] ), .B(n2241), .Y(n2243) );
  OAI21X1 U2411 ( .A(1'b0), .B(n2148), .C(n2281), .Y(n2283) );
  OAI21X1 U2412 ( .A(1'b0), .B(n2149), .C(n2169), .Y(n2171) );
  OAI21X1 U2413 ( .A(1'b0), .B(n2148), .C(n2292), .Y(n2294) );
  OAI21X1 U2414 ( .A(1'b0), .B(n2149), .C(n2180), .Y(n2182) );
  OAI21X1 U2415 ( .A(1'b0), .B(n2148), .C(n2302), .Y(n2304) );
  OAI21X1 U2416 ( .A(1'b0), .B(n2149), .C(n2190), .Y(n2192) );
  OAI21X1 U2417 ( .A(1'b0), .B(n2148), .C(n2312), .Y(n2314) );
  OAI21X1 U2418 ( .A(1'b0), .B(n2149), .C(n2200), .Y(n2202) );
  OAI21X1 U2419 ( .A(1'b0), .B(n2148), .C(n2322), .Y(n2324) );
  OAI21X1 U2420 ( .A(1'b0), .B(n2149), .C(n2210), .Y(n2212) );
  OAI21X1 U2421 ( .A(1'b0), .B(n2148), .C(n2332), .Y(n2334) );
  OAI21X1 U2422 ( .A(1'b0), .B(n2149), .C(n2220), .Y(n2222) );
  OAI21X1 U2423 ( .A(1'b0), .B(n2148), .C(n2345), .Y(n2348) );
  OAI21X1 U2424 ( .A(1'b0), .B(n2149), .C(n2233), .Y(n2236) );
  INVX2 U2425 ( .A(n2744), .Y(n2639) );
  INVX2 U2426 ( .A(n2746), .Y(n2640) );
  BUFX2 U2427 ( .A(n2346), .Y(n2148) );
  BUFX2 U2428 ( .A(n2234), .Y(n2149) );
  BUFX2 U2429 ( .A(n2614), .Y(n2150) );
  AND2X2 U2430 ( .A(n2835), .B(n2836), .Y(n2344) );
  AND2X2 U2431 ( .A(N1339), .B(N1490), .Y(n2232) );
  BUFX2 U2432 ( .A(n2508), .Y(n2151) );
  INVX2 U2433 ( .A(n2618), .Y(n2152) );
  INVX4 U2434 ( .A(n2446), .Y(n2430) );
  NOR2X1 U2449 ( .A(N1339), .B(n2836), .Y(n2160) );
  NOR2X1 U2450 ( .A(n2827), .B(n2254), .Y(n2162) );
  AND2X1 U2451 ( .A(n2160), .B(n2162), .Y(n2230) );
  NOR2X1 U2452 ( .A(n2254), .B(N1337), .Y(n2159) );
  NOR2X1 U2453 ( .A(N1490), .B(N1339), .Y(n2163) );
  AND2X1 U2454 ( .A(n2159), .B(n2163), .Y(n2229) );
  AOI22X1 U2455 ( .A(\slavedata[6][0] ), .B(n2230), .C(\slavedata[5][0] ), .D(
        n2229), .Y(n2167) );
  NAND2X1 U2456 ( .A(n2836), .B(N1339), .Y(n2234) );
  AOI21X1 U2457 ( .A(n2232), .B(n2793), .C(n2827), .Y(n2153) );
  OAI21X1 U2458 ( .A(\slavedata[11][0] ), .B(n2149), .C(n2153), .Y(n2158) );
  OAI22X1 U2459 ( .A(\slavedata[3][0] ), .B(n2256), .C(\slavedata[2][0] ), .D(
        n2255), .Y(n2157) );
  AOI21X1 U2460 ( .A(n2232), .B(n2253), .C(N1337), .Y(n2154) );
  OAI21X1 U2461 ( .A(\slavedata[9][0] ), .B(n2149), .C(n2154), .Y(n2156) );
  OAI22X1 U2462 ( .A(\slavedata[1][0] ), .B(n2256), .C(\slavedata[0][0] ), .D(
        n2255), .Y(n2155) );
  OAI22X1 U2463 ( .A(n2158), .B(n2157), .C(n2156), .D(n2155), .Y(n2161) );
  AND2X1 U2464 ( .A(n2160), .B(n2159), .Y(n2239) );
  AOI22X1 U2465 ( .A(n2161), .B(n2254), .C(\slavedata[4][0] ), .D(n2239), .Y(
        n2166) );
  NOR2X1 U2466 ( .A(n2254), .B(n2149), .Y(n2244) );
  AND2X1 U2467 ( .A(n2163), .B(n2162), .Y(n2242) );
  AND2X1 U2468 ( .A(n2232), .B(N1338), .Y(n2241) );
  AOI22X1 U2469 ( .A(\slavedata[7][0] ), .B(n2242), .C(\slavedata[12][0] ), 
        .D(n2241), .Y(n2164) );
  AOI21X1 U2470 ( .A(clear), .B(n2244), .C(n2264), .Y(n2165) );
  NAND3X1 U2471 ( .A(n2167), .B(n2166), .C(n2165), .Y(N1541) );
  AOI21X1 U2472 ( .A(n2232), .B(n2596), .C(n2827), .Y(n2168) );
  OAI21X1 U2473 ( .A(\slavedata[11][1] ), .B(n2149), .C(n2168), .Y(n2173) );
  OAI22X1 U2474 ( .A(\slavedata[3][1] ), .B(n2256), .C(\slavedata[2][1] ), .D(
        n2255), .Y(n2172) );
  AOI21X1 U2475 ( .A(n2232), .B(n2252), .C(N1337), .Y(n2169) );
  OAI22X1 U2476 ( .A(\slavedata[1][1] ), .B(n2256), .C(\slavedata[0][1] ), .D(
        n2255), .Y(n2170) );
  OAI22X1 U2477 ( .A(n2173), .B(n2172), .C(n2171), .D(n2170), .Y(n2174) );
  AOI22X1 U2478 ( .A(n2174), .B(n2254), .C(\slavedata[4][1] ), .D(n2239), .Y(
        n2177) );
  AOI21X1 U2479 ( .A(\slavedata[13][1] ), .B(n2244), .C(n2263), .Y(n2176) );
  NAND3X1 U2480 ( .A(n2178), .B(n2177), .C(n2176), .Y(N1540) );
  AOI21X1 U2481 ( .A(n2232), .B(n2593), .C(n2827), .Y(n2179) );
  OAI21X1 U2482 ( .A(\slavedata[11][2] ), .B(n2149), .C(n2179), .Y(n2184) );
  OAI22X1 U2483 ( .A(\slavedata[3][2] ), .B(n2256), .C(\slavedata[2][2] ), .D(
        n2255), .Y(n2183) );
  AOI21X1 U2484 ( .A(n2232), .B(n2251), .C(N1337), .Y(n2180) );
  OAI22X1 U2485 ( .A(\slavedata[1][2] ), .B(n2256), .C(\slavedata[0][2] ), .D(
        n2255), .Y(n2181) );
  OAI22X1 U2486 ( .A(n2184), .B(n2183), .C(n2182), .D(n2181), .Y(n2185) );
  AOI22X1 U2487 ( .A(n2185), .B(n2254), .C(\slavedata[4][2] ), .D(n2239), .Y(
        n2188) );
  AOI21X1 U2488 ( .A(\slavedata[13][2] ), .B(n2244), .C(n2262), .Y(n2187) );
  AOI21X1 U2489 ( .A(n2232), .B(n2590), .C(n2827), .Y(n2189) );
  OAI21X1 U2490 ( .A(\slavedata[11][3] ), .B(n2149), .C(n2189), .Y(n2194) );
  OAI22X1 U2491 ( .A(\slavedata[3][3] ), .B(n2256), .C(\slavedata[2][3] ), .D(
        n2255), .Y(n2193) );
  AOI21X1 U2492 ( .A(n2232), .B(n2250), .C(N1337), .Y(n2190) );
  OAI22X1 U2493 ( .A(\slavedata[1][3] ), .B(n2256), .C(\slavedata[0][3] ), .D(
        n2255), .Y(n2191) );
  OAI22X1 U2494 ( .A(n2194), .B(n2193), .C(n2192), .D(n2191), .Y(n2195) );
  AOI22X1 U2495 ( .A(n2195), .B(n2254), .C(\slavedata[4][3] ), .D(n2239), .Y(
        n2198) );
  AOI21X1 U2496 ( .A(\slavedata[13][3] ), .B(n2244), .C(n2261), .Y(n2197) );
  AOI21X1 U2497 ( .A(n2232), .B(n2587), .C(n2827), .Y(n2199) );
  OAI21X1 U2498 ( .A(\slavedata[11][4] ), .B(n2149), .C(n2199), .Y(n2204) );
  OAI22X1 U2499 ( .A(\slavedata[3][4] ), .B(n2256), .C(\slavedata[2][4] ), .D(
        n2255), .Y(n2203) );
  AOI21X1 U2500 ( .A(n2232), .B(n2249), .C(N1337), .Y(n2200) );
  OAI22X1 U2501 ( .A(\slavedata[1][4] ), .B(n2256), .C(\slavedata[0][4] ), .D(
        n2255), .Y(n2201) );
  OAI22X1 U2502 ( .A(n2204), .B(n2203), .C(n2202), .D(n2201), .Y(n2205) );
  AOI22X1 U2503 ( .A(n2205), .B(n2254), .C(\slavedata[4][4] ), .D(n2239), .Y(
        n2208) );
  AOI21X1 U2504 ( .A(\slavedata[13][4] ), .B(n2244), .C(n2260), .Y(n2207) );
  AOI21X1 U2505 ( .A(n2232), .B(n2584), .C(n2827), .Y(n2209) );
  OAI21X1 U2506 ( .A(\slavedata[11][5] ), .B(n2149), .C(n2209), .Y(n2214) );
  OAI22X1 U2507 ( .A(\slavedata[3][5] ), .B(n2256), .C(\slavedata[2][5] ), .D(
        n2255), .Y(n2213) );
  AOI21X1 U2508 ( .A(n2232), .B(n2248), .C(N1337), .Y(n2210) );
  OAI22X1 U2509 ( .A(\slavedata[1][5] ), .B(n2256), .C(\slavedata[0][5] ), .D(
        n2255), .Y(n2211) );
  OAI22X1 U2510 ( .A(n2214), .B(n2213), .C(n2212), .D(n2211), .Y(n2215) );
  AOI21X1 U2511 ( .A(\slavedata[13][5] ), .B(n2244), .C(n2259), .Y(n2217) );
  AOI21X1 U2512 ( .A(n2232), .B(n2581), .C(n2827), .Y(n2219) );
  OAI21X1 U2513 ( .A(\slavedata[11][6] ), .B(n2149), .C(n2219), .Y(n2224) );
  OAI22X1 U2514 ( .A(\slavedata[3][6] ), .B(n2256), .C(\slavedata[2][6] ), .D(
        n2255), .Y(n2223) );
  AOI21X1 U2515 ( .A(n2232), .B(n2247), .C(N1337), .Y(n2220) );
  OAI22X1 U2516 ( .A(\slavedata[1][6] ), .B(n2256), .C(\slavedata[0][6] ), .D(
        n2255), .Y(n2221) );
  OAI22X1 U2517 ( .A(n2224), .B(n2223), .C(n2222), .D(n2221), .Y(n2225) );
  AOI21X1 U2518 ( .A(\slavedata[13][6] ), .B(n2244), .C(n2258), .Y(n2227) );
  AOI21X1 U2519 ( .A(n2232), .B(n2575), .C(n2827), .Y(n2231) );
  OAI21X1 U2520 ( .A(\slavedata[11][7] ), .B(n2149), .C(n2231), .Y(n2238) );
  OAI22X1 U2521 ( .A(\slavedata[3][7] ), .B(n2256), .C(\slavedata[2][7] ), .D(
        n2255), .Y(n2237) );
  OAI22X1 U2522 ( .A(\slavedata[1][7] ), .B(n2256), .C(\slavedata[0][7] ), .D(
        n2255), .Y(n2235) );
  OAI22X1 U2523 ( .A(n2238), .B(n2237), .C(n2236), .D(n2235), .Y(n2240) );
  AOI21X1 U2524 ( .A(\slavedata[13][7] ), .B(n2244), .C(n2257), .Y(n2245) );
  INVX2 U2525 ( .A(\slavedata[8][6] ), .Y(n2247) );
  INVX2 U2526 ( .A(\slavedata[8][5] ), .Y(n2248) );
  INVX2 U2527 ( .A(\slavedata[8][4] ), .Y(n2249) );
  INVX2 U2528 ( .A(\slavedata[8][3] ), .Y(n2250) );
  INVX2 U2529 ( .A(\slavedata[8][2] ), .Y(n2251) );
  INVX2 U2530 ( .A(\slavedata[8][1] ), .Y(n2252) );
  INVX2 U2531 ( .A(\slavedata[8][0] ), .Y(n2253) );
  INVX2 U2532 ( .A(N1338), .Y(n2254) );
  INVX2 U2533 ( .A(n2160), .Y(n2255) );
  INVX2 U2534 ( .A(n2163), .Y(n2256) );
  INVX2 U2535 ( .A(n2243), .Y(n2257) );
  INVX2 U2536 ( .A(n2226), .Y(n2258) );
  INVX2 U2537 ( .A(n2216), .Y(n2259) );
  INVX2 U2538 ( .A(n2206), .Y(n2260) );
  INVX2 U2539 ( .A(n2196), .Y(n2261) );
  INVX2 U2540 ( .A(n2186), .Y(n2262) );
  INVX2 U2541 ( .A(n2175), .Y(n2263) );
  INVX2 U2542 ( .A(n2164), .Y(n2264) );
  NOR2X1 U2543 ( .A(n2835), .B(N1490), .Y(n2272) );
  NOR2X1 U2544 ( .A(n2786), .B(n2747), .Y(n2274) );
  AND2X1 U2545 ( .A(n2272), .B(n2274), .Y(n2342) );
  NOR2X1 U2546 ( .A(n2747), .B(\next_address[1] ), .Y(n2271) );
  NOR2X1 U2547 ( .A(n2836), .B(n2835), .Y(n2275) );
  AND2X1 U2548 ( .A(n2271), .B(n2275), .Y(n2341) );
  AOI22X1 U2549 ( .A(\slavedata[6][0] ), .B(n2342), .C(\slavedata[5][0] ), .D(
        n2341), .Y(n2279) );
  NAND2X1 U2550 ( .A(N1490), .B(n2835), .Y(n2346) );
  AOI21X1 U2551 ( .A(n2344), .B(n2793), .C(n2786), .Y(n2265) );
  OAI21X1 U2552 ( .A(\slavedata[11][0] ), .B(n2148), .C(n2265), .Y(n2270) );
  OAI22X1 U2553 ( .A(\slavedata[3][0] ), .B(n2360), .C(\slavedata[2][0] ), .D(
        n2359), .Y(n2269) );
  AOI21X1 U2554 ( .A(n2344), .B(n2253), .C(\next_address[1] ), .Y(n2266) );
  OAI21X1 U2555 ( .A(\slavedata[9][0] ), .B(n2148), .C(n2266), .Y(n2268) );
  OAI22X1 U2556 ( .A(\slavedata[1][0] ), .B(n2360), .C(\slavedata[0][0] ), .D(
        n2359), .Y(n2267) );
  OAI22X1 U2557 ( .A(n2270), .B(n2269), .C(n2268), .D(n2267), .Y(n2273) );
  AND2X1 U2558 ( .A(n2272), .B(n2271), .Y(n2351) );
  AOI22X1 U2559 ( .A(n2273), .B(n2747), .C(\slavedata[4][0] ), .D(n2351), .Y(
        n2278) );
  NOR2X1 U2560 ( .A(n2747), .B(n2148), .Y(n2356) );
  AND2X1 U2561 ( .A(n2275), .B(n2274), .Y(n2354) );
  AND2X1 U2562 ( .A(n2344), .B(n2834), .Y(n2353) );
  AOI22X1 U2563 ( .A(\slavedata[7][0] ), .B(n2354), .C(\slavedata[12][0] ), 
        .D(n2353), .Y(n2276) );
  AOI21X1 U2564 ( .A(clear), .B(n2356), .C(n2368), .Y(n2277) );
  NAND3X1 U2565 ( .A(n2279), .B(n2278), .C(n2277), .Y(N1563) );
  AOI21X1 U2566 ( .A(n2344), .B(n2596), .C(n2786), .Y(n2280) );
  OAI21X1 U2567 ( .A(\slavedata[11][1] ), .B(n2148), .C(n2280), .Y(n2285) );
  OAI22X1 U2568 ( .A(\slavedata[3][1] ), .B(n2360), .C(\slavedata[2][1] ), .D(
        n2359), .Y(n2284) );
  AOI21X1 U2569 ( .A(n2344), .B(n2252), .C(\next_address[1] ), .Y(n2281) );
  OAI22X1 U2570 ( .A(\slavedata[1][1] ), .B(n2360), .C(\slavedata[0][1] ), .D(
        n2359), .Y(n2282) );
  OAI22X1 U2571 ( .A(n2285), .B(n2284), .C(n2283), .D(n2282), .Y(n2286) );
  AOI22X1 U2572 ( .A(n2286), .B(n2747), .C(\slavedata[4][1] ), .D(n2351), .Y(
        n2289) );
  AOI21X1 U2573 ( .A(\slavedata[13][1] ), .B(n2356), .C(n2367), .Y(n2288) );
  NAND3X1 U2574 ( .A(n2290), .B(n2289), .C(n2288), .Y(N1562) );
  AOI21X1 U2575 ( .A(n2344), .B(n2593), .C(n2786), .Y(n2291) );
  OAI21X1 U2576 ( .A(\slavedata[11][2] ), .B(n2148), .C(n2291), .Y(n2296) );
  OAI22X1 U2577 ( .A(\slavedata[3][2] ), .B(n2360), .C(\slavedata[2][2] ), .D(
        n2359), .Y(n2295) );
  AOI21X1 U2578 ( .A(n2344), .B(n2251), .C(\next_address[1] ), .Y(n2292) );
  OAI22X1 U2579 ( .A(\slavedata[1][2] ), .B(n2360), .C(\slavedata[0][2] ), .D(
        n2359), .Y(n2293) );
  OAI22X1 U2580 ( .A(n2296), .B(n2295), .C(n2294), .D(n2293), .Y(n2297) );
  AOI22X1 U2581 ( .A(n2297), .B(n2747), .C(\slavedata[4][2] ), .D(n2351), .Y(
        n2300) );
  AOI21X1 U2582 ( .A(\slavedata[13][2] ), .B(n2356), .C(n2366), .Y(n2299) );
  AOI21X1 U2583 ( .A(n2344), .B(n2590), .C(n2786), .Y(n2301) );
  OAI21X1 U2584 ( .A(\slavedata[11][3] ), .B(n2148), .C(n2301), .Y(n2306) );
  OAI22X1 U2585 ( .A(\slavedata[3][3] ), .B(n2360), .C(\slavedata[2][3] ), .D(
        n2359), .Y(n2305) );
  AOI21X1 U2586 ( .A(n2344), .B(n2250), .C(\next_address[1] ), .Y(n2302) );
  OAI22X1 U2587 ( .A(\slavedata[1][3] ), .B(n2360), .C(\slavedata[0][3] ), .D(
        n2359), .Y(n2303) );
  OAI22X1 U2588 ( .A(n2306), .B(n2305), .C(n2304), .D(n2303), .Y(n2307) );
  AOI22X1 U2589 ( .A(n2307), .B(n2747), .C(\slavedata[4][3] ), .D(n2351), .Y(
        n2310) );
  AOI21X1 U2590 ( .A(\slavedata[13][3] ), .B(n2356), .C(n2365), .Y(n2309) );
  AOI21X1 U2591 ( .A(n2344), .B(n2587), .C(n2786), .Y(n2311) );
  OAI21X1 U2592 ( .A(\slavedata[11][4] ), .B(n2148), .C(n2311), .Y(n2316) );
  OAI22X1 U2593 ( .A(\slavedata[3][4] ), .B(n2360), .C(\slavedata[2][4] ), .D(
        n2359), .Y(n2315) );
  AOI21X1 U2594 ( .A(n2344), .B(n2249), .C(\next_address[1] ), .Y(n2312) );
  OAI22X1 U2595 ( .A(\slavedata[1][4] ), .B(n2360), .C(\slavedata[0][4] ), .D(
        n2359), .Y(n2313) );
  OAI22X1 U2596 ( .A(n2316), .B(n2315), .C(n2314), .D(n2313), .Y(n2317) );
  AOI22X1 U2597 ( .A(n2317), .B(n2747), .C(\slavedata[4][4] ), .D(n2351), .Y(
        n2320) );
  AOI21X1 U2598 ( .A(\slavedata[13][4] ), .B(n2356), .C(n2364), .Y(n2319) );
  AOI21X1 U2599 ( .A(n2344), .B(n2584), .C(n2786), .Y(n2321) );
  OAI21X1 U2600 ( .A(\slavedata[11][5] ), .B(n2148), .C(n2321), .Y(n2326) );
  OAI22X1 U2601 ( .A(\slavedata[3][5] ), .B(n2360), .C(\slavedata[2][5] ), .D(
        n2359), .Y(n2325) );
  AOI21X1 U2602 ( .A(n2344), .B(n2248), .C(\next_address[1] ), .Y(n2322) );
  OAI22X1 U2603 ( .A(\slavedata[1][5] ), .B(n2360), .C(\slavedata[0][5] ), .D(
        n2359), .Y(n2323) );
  OAI22X1 U2604 ( .A(n2326), .B(n2325), .C(n2324), .D(n2323), .Y(n2327) );
  AOI21X1 U2605 ( .A(\slavedata[13][5] ), .B(n2356), .C(n2363), .Y(n2329) );
  AOI21X1 U2606 ( .A(n2344), .B(n2581), .C(n2786), .Y(n2331) );
  OAI21X1 U2607 ( .A(\slavedata[11][6] ), .B(n2148), .C(n2331), .Y(n2336) );
  OAI22X1 U2608 ( .A(\slavedata[3][6] ), .B(n2360), .C(\slavedata[2][6] ), .D(
        n2359), .Y(n2335) );
  AOI21X1 U2609 ( .A(n2344), .B(n2247), .C(\next_address[1] ), .Y(n2332) );
  OAI22X1 U2610 ( .A(\slavedata[1][6] ), .B(n2360), .C(\slavedata[0][6] ), .D(
        n2359), .Y(n2333) );
  OAI22X1 U2611 ( .A(n2336), .B(n2335), .C(n2334), .D(n2333), .Y(n2337) );
  AOI21X1 U2612 ( .A(\slavedata[13][6] ), .B(n2356), .C(n2362), .Y(n2339) );
  AOI21X1 U2613 ( .A(n2344), .B(n2575), .C(n2786), .Y(n2343) );
  OAI21X1 U2614 ( .A(\slavedata[11][7] ), .B(n2148), .C(n2343), .Y(n2350) );
  OAI22X1 U2615 ( .A(\slavedata[3][7] ), .B(n2360), .C(\slavedata[2][7] ), .D(
        n2359), .Y(n2349) );
  OAI22X1 U2616 ( .A(\slavedata[1][7] ), .B(n2360), .C(\slavedata[0][7] ), .D(
        n2359), .Y(n2347) );
  OAI22X1 U2617 ( .A(n2350), .B(n2349), .C(n2348), .D(n2347), .Y(n2352) );
  AOI21X1 U2618 ( .A(\slavedata[13][7] ), .B(n2356), .C(n2361), .Y(n2357) );
  INVX2 U2619 ( .A(n2272), .Y(n2359) );
  INVX2 U2620 ( .A(n2275), .Y(n2360) );
  INVX2 U2621 ( .A(n2355), .Y(n2361) );
  INVX2 U2622 ( .A(n2338), .Y(n2362) );
  INVX2 U2623 ( .A(n2328), .Y(n2363) );
  INVX2 U2624 ( .A(n2318), .Y(n2364) );
  INVX2 U2625 ( .A(n2308), .Y(n2365) );
  INVX2 U2626 ( .A(n2298), .Y(n2366) );
  INVX2 U2627 ( .A(n2287), .Y(n2367) );
  INVX2 U2628 ( .A(n2276), .Y(n2368) );
  OAI21X1 U2629 ( .A(n2369), .B(n2370), .C(n2371), .Y(tx_packet[1]) );
  INVX1 U2630 ( .A(tx_packet[3]), .Y(n2371) );
  OAI21X1 U2631 ( .A(n2372), .B(n2373), .C(n2374), .Y(tx_packet[3]) );
  NAND2X1 U2632 ( .A(\slavedata[12][0] ), .B(n2375), .Y(n2373) );
  INVX1 U2633 ( .A(n2375), .Y(n2370) );
  NOR2X1 U2634 ( .A(n2376), .B(n2377), .Y(tx_packet[0]) );
  NAND2X1 U2635 ( .A(n2375), .B(n2372), .Y(n2377) );
  NOR2X1 U2636 ( .A(n2378), .B(\slavedata[12][2] ), .Y(n2375) );
  AOI21X1 U2637 ( .A(n2379), .B(n2380), .C(n2381), .Y(tx_data[7]) );
  AOI22X1 U2638 ( .A(\slavedata[3][7] ), .B(n2382), .C(\slavedata[1][7] ), .D(
        n2383), .Y(n2380) );
  AOI22X1 U2639 ( .A(\slavedata[2][7] ), .B(n2384), .C(\slavedata[0][7] ), .D(
        n2385), .Y(n2379) );
  AOI21X1 U2640 ( .A(n2386), .B(n2387), .C(n2381), .Y(tx_data[6]) );
  AOI22X1 U2641 ( .A(\slavedata[3][6] ), .B(n2382), .C(\slavedata[1][6] ), .D(
        n2383), .Y(n2387) );
  AOI22X1 U2642 ( .A(\slavedata[2][6] ), .B(n2384), .C(\slavedata[0][6] ), .D(
        n2385), .Y(n2386) );
  AOI21X1 U2643 ( .A(n2388), .B(n2389), .C(n2381), .Y(tx_data[5]) );
  AOI22X1 U2644 ( .A(\slavedata[3][5] ), .B(n2382), .C(\slavedata[1][5] ), .D(
        n2383), .Y(n2389) );
  AOI22X1 U2645 ( .A(\slavedata[2][5] ), .B(n2384), .C(\slavedata[0][5] ), .D(
        n2385), .Y(n2388) );
  AOI21X1 U2646 ( .A(n2390), .B(n2391), .C(n2381), .Y(tx_data[4]) );
  AOI22X1 U2647 ( .A(\slavedata[3][4] ), .B(n2382), .C(\slavedata[1][4] ), .D(
        n2383), .Y(n2391) );
  AOI22X1 U2648 ( .A(\slavedata[2][4] ), .B(n2384), .C(\slavedata[0][4] ), .D(
        n2385), .Y(n2390) );
  AOI21X1 U2649 ( .A(n2392), .B(n2393), .C(n2381), .Y(tx_data[3]) );
  AOI22X1 U2650 ( .A(\slavedata[3][3] ), .B(n2382), .C(\slavedata[1][3] ), .D(
        n2383), .Y(n2393) );
  AOI22X1 U2651 ( .A(\slavedata[2][3] ), .B(n2384), .C(\slavedata[0][3] ), .D(
        n2385), .Y(n2392) );
  AOI21X1 U2652 ( .A(n2394), .B(n2395), .C(n2381), .Y(tx_data[2]) );
  AOI22X1 U2653 ( .A(\slavedata[3][2] ), .B(n2382), .C(\slavedata[1][2] ), .D(
        n2383), .Y(n2395) );
  AOI22X1 U2654 ( .A(\slavedata[2][2] ), .B(n2384), .C(\slavedata[0][2] ), .D(
        n2385), .Y(n2394) );
  AOI21X1 U2655 ( .A(n2396), .B(n2397), .C(n2381), .Y(tx_data[1]) );
  AOI22X1 U2656 ( .A(\slavedata[3][1] ), .B(n2382), .C(\slavedata[1][1] ), .D(
        n2383), .Y(n2397) );
  AOI22X1 U2657 ( .A(\slavedata[2][1] ), .B(n2384), .C(\slavedata[0][1] ), .D(
        n2385), .Y(n2396) );
  AOI21X1 U2658 ( .A(n2398), .B(n2399), .C(n2381), .Y(tx_data[0]) );
  AOI22X1 U2659 ( .A(\slavedata[3][0] ), .B(n2382), .C(\slavedata[1][0] ), .D(
        n2383), .Y(n2399) );
  AOI22X1 U2660 ( .A(\slavedata[2][0] ), .B(n2384), .C(\slavedata[0][0] ), .D(
        n2385), .Y(n2398) );
  XOR2X1 U2661 ( .A(flush_state[1]), .B(flush_state[0]), .Y(
        next_state_flush[1]) );
  NOR2X1 U2662 ( .A(flush_state[0]), .B(n2400), .Y(next_state_flush[0]) );
  MUX2X1 U2663 ( .B(n2401), .A(n2402), .S(flush_state[1]), .Y(n2400) );
  NOR2X1 U2664 ( .A(n2403), .B(n2404), .Y(n2402) );
  INVX1 U2665 ( .A(n2405), .Y(n2404) );
  NOR3X1 U2666 ( .A(\next_slavedata[8][1] ), .B(\next_slavedata[8][2] ), .C(
        \next_slavedata[8][0] ), .Y(n2405) );
  NAND3X1 U2667 ( .A(n2406), .B(n2407), .C(n2408), .Y(n2403) );
  NOR2X1 U2668 ( .A(\next_slavedata[8][6] ), .B(\next_slavedata[8][5] ), .Y(
        n2408) );
  INVX1 U2669 ( .A(\next_slavedata[8][4] ), .Y(n2407) );
  INVX1 U2670 ( .A(\next_slavedata[8][3] ), .Y(n2406) );
  NOR2X1 U2671 ( .A(n2409), .B(n2410), .Y(n2401) );
  OAI21X1 U2672 ( .A(n2412), .B(n2381), .C(n2413), .Y(\next_slavedata[9][0] )
         );
  NAND2X1 U2673 ( .A(\slavedata[9][0] ), .B(n2411), .Y(n2413) );
  OAI21X1 U2674 ( .A(n2382), .B(n2414), .C(write), .Y(n2411) );
  AOI21X1 U2675 ( .A(data_state[2]), .B(data_state[1]), .C(n2415), .Y(n2414)
         );
  XNOR2X1 U2676 ( .A(data_state[1]), .B(data_state[2]), .Y(n2412) );
  NOR2X1 U2677 ( .A(n2416), .B(n2417), .Y(\next_slavedata[4][4] ) );
  NAND2X1 U2678 ( .A(rx_packet[3]), .B(rx_packet[1]), .Y(n2417) );
  NAND2X1 U2679 ( .A(n2418), .B(n2419), .Y(n2416) );
  NOR2X1 U2680 ( .A(n2420), .B(n2421), .Y(\next_slavedata[4][3] ) );
  NAND2X1 U2681 ( .A(rx_packet[1]), .B(n2418), .Y(n2421) );
  INVX1 U2682 ( .A(rx_packet[0]), .Y(n2418) );
  NOR2X1 U2683 ( .A(n2420), .B(n2422), .Y(\next_slavedata[4][2] ) );
  NAND2X1 U2684 ( .A(rx_packet[0]), .B(n2423), .Y(n2422) );
  NAND2X1 U2685 ( .A(n2419), .B(n2424), .Y(n2420) );
  INVX1 U2686 ( .A(rx_packet[3]), .Y(n2424) );
  NOR2X1 U2687 ( .A(n2425), .B(n2426), .Y(\next_slavedata[4][1] ) );
  NAND2X1 U2688 ( .A(rx_packet[0]), .B(rx_packet[3]), .Y(n2426) );
  NAND2X1 U2689 ( .A(n2423), .B(n2419), .Y(n2425) );
  INVX1 U2690 ( .A(rx_packet[2]), .Y(n2419) );
  INVX1 U2691 ( .A(rx_packet[1]), .Y(n2423) );
  OAI21X1 U2692 ( .A(n2427), .B(n2428), .C(n2429), .Y(\next_slavedata[3][7] )
         );
  AOI22X1 U2693 ( .A(hwdata[31]), .B(n2430), .C(n2431), .D(\slavedata[3][7] ), 
        .Y(n2429) );
  OAI21X1 U2694 ( .A(n2427), .B(n2432), .C(n2433), .Y(\next_slavedata[3][6] )
         );
  AOI22X1 U2695 ( .A(hwdata[30]), .B(n2430), .C(n2431), .D(\slavedata[3][6] ), 
        .Y(n2433) );
  OAI21X1 U2696 ( .A(n2427), .B(n2434), .C(n2435), .Y(\next_slavedata[3][5] )
         );
  AOI22X1 U2697 ( .A(hwdata[29]), .B(n2430), .C(n2431), .D(\slavedata[3][5] ), 
        .Y(n2435) );
  OAI21X1 U2698 ( .A(n2427), .B(n2436), .C(n2437), .Y(\next_slavedata[3][4] )
         );
  AOI22X1 U2699 ( .A(hwdata[28]), .B(n2430), .C(n2431), .D(\slavedata[3][4] ), 
        .Y(n2437) );
  OAI21X1 U2700 ( .A(n2427), .B(n2438), .C(n2439), .Y(\next_slavedata[3][3] )
         );
  AOI22X1 U2701 ( .A(hwdata[27]), .B(n2430), .C(n2431), .D(\slavedata[3][3] ), 
        .Y(n2439) );
  OAI21X1 U2702 ( .A(n2427), .B(n2440), .C(n2441), .Y(\next_slavedata[3][2] )
         );
  AOI22X1 U2703 ( .A(hwdata[26]), .B(n2430), .C(n2431), .D(\slavedata[3][2] ), 
        .Y(n2441) );
  OAI21X1 U2704 ( .A(n2427), .B(n2442), .C(n2443), .Y(\next_slavedata[3][1] )
         );
  AOI22X1 U2705 ( .A(hwdata[25]), .B(n2430), .C(n2431), .D(\slavedata[3][1] ), 
        .Y(n2443) );
  OAI21X1 U2706 ( .A(n2427), .B(n2444), .C(n2445), .Y(\next_slavedata[3][0] )
         );
  AOI22X1 U2707 ( .A(hwdata[24]), .B(n2430), .C(n2431), .D(\slavedata[3][0] ), 
        .Y(n2445) );
  AND2X1 U2708 ( .A(n2446), .B(n2427), .Y(n2431) );
  NAND2X1 U2709 ( .A(get_rx_data), .B(n2382), .Y(n2427) );
  OAI21X1 U2710 ( .A(n2428), .B(n2447), .C(n2448), .Y(\next_slavedata[2][7] )
         );
  AOI22X1 U2711 ( .A(hwdata[23]), .B(n2430), .C(n2449), .D(\slavedata[2][7] ), 
        .Y(n2448) );
  OAI21X1 U2712 ( .A(n2432), .B(n2447), .C(n2450), .Y(\next_slavedata[2][6] )
         );
  AOI22X1 U2713 ( .A(hwdata[22]), .B(n2430), .C(n2449), .D(\slavedata[2][6] ), 
        .Y(n2450) );
  OAI21X1 U2714 ( .A(n2434), .B(n2447), .C(n2451), .Y(\next_slavedata[2][5] )
         );
  AOI22X1 U2715 ( .A(hwdata[21]), .B(n2430), .C(n2449), .D(\slavedata[2][5] ), 
        .Y(n2451) );
  OAI21X1 U2716 ( .A(n2436), .B(n2447), .C(n2452), .Y(\next_slavedata[2][4] )
         );
  AOI22X1 U2717 ( .A(hwdata[20]), .B(n2430), .C(n2449), .D(\slavedata[2][4] ), 
        .Y(n2452) );
  OAI21X1 U2718 ( .A(n2438), .B(n2447), .C(n2453), .Y(\next_slavedata[2][3] )
         );
  AOI22X1 U2719 ( .A(hwdata[19]), .B(n2430), .C(n2449), .D(\slavedata[2][3] ), 
        .Y(n2453) );
  OAI21X1 U2720 ( .A(n2440), .B(n2447), .C(n2454), .Y(\next_slavedata[2][2] )
         );
  AOI22X1 U2721 ( .A(hwdata[18]), .B(n2430), .C(n2449), .D(\slavedata[2][2] ), 
        .Y(n2454) );
  OAI21X1 U2722 ( .A(n2442), .B(n2447), .C(n2455), .Y(\next_slavedata[2][1] )
         );
  AOI22X1 U2723 ( .A(hwdata[17]), .B(n2430), .C(n2449), .D(\slavedata[2][1] ), 
        .Y(n2455) );
  OAI21X1 U2724 ( .A(n2444), .B(n2447), .C(n2456), .Y(\next_slavedata[2][0] )
         );
  AOI22X1 U2725 ( .A(hwdata[16]), .B(n2430), .C(n2449), .D(\slavedata[2][0] ), 
        .Y(n2456) );
  AND2X1 U2726 ( .A(n2447), .B(n2446), .Y(n2449) );
  NAND2X1 U2727 ( .A(get_rx_data), .B(n2384), .Y(n2447) );
  OAI21X1 U2728 ( .A(n2428), .B(n2457), .C(n2458), .Y(\next_slavedata[1][7] )
         );
  AOI22X1 U2729 ( .A(hwdata[15]), .B(n2430), .C(n2459), .D(\slavedata[1][7] ), 
        .Y(n2458) );
  OAI21X1 U2730 ( .A(n2432), .B(n2457), .C(n2460), .Y(\next_slavedata[1][6] )
         );
  AOI22X1 U2731 ( .A(hwdata[14]), .B(n2430), .C(n2459), .D(\slavedata[1][6] ), 
        .Y(n2460) );
  OAI21X1 U2732 ( .A(n2434), .B(n2457), .C(n2461), .Y(\next_slavedata[1][5] )
         );
  AOI22X1 U2733 ( .A(hwdata[13]), .B(n2430), .C(n2459), .D(\slavedata[1][5] ), 
        .Y(n2461) );
  OAI21X1 U2734 ( .A(n2436), .B(n2457), .C(n2462), .Y(\next_slavedata[1][4] )
         );
  AOI22X1 U2735 ( .A(hwdata[12]), .B(n2430), .C(n2459), .D(\slavedata[1][4] ), 
        .Y(n2462) );
  OAI21X1 U2736 ( .A(n2438), .B(n2457), .C(n2463), .Y(\next_slavedata[1][3] )
         );
  AOI22X1 U2737 ( .A(hwdata[11]), .B(n2430), .C(n2459), .D(\slavedata[1][3] ), 
        .Y(n2463) );
  OAI21X1 U2738 ( .A(n2440), .B(n2457), .C(n2464), .Y(\next_slavedata[1][2] )
         );
  AOI22X1 U2739 ( .A(hwdata[10]), .B(n2430), .C(n2459), .D(\slavedata[1][2] ), 
        .Y(n2464) );
  OAI21X1 U2740 ( .A(n2442), .B(n2457), .C(n2465), .Y(\next_slavedata[1][1] )
         );
  AOI22X1 U2741 ( .A(hwdata[9]), .B(n2430), .C(n2459), .D(\slavedata[1][1] ), 
        .Y(n2465) );
  OAI21X1 U2742 ( .A(n2444), .B(n2457), .C(n2466), .Y(\next_slavedata[1][0] )
         );
  AOI22X1 U2743 ( .A(hwdata[8]), .B(n2430), .C(n2459), .D(\slavedata[1][0] ), 
        .Y(n2466) );
  AND2X1 U2744 ( .A(n2457), .B(n2446), .Y(n2459) );
  NAND2X1 U2745 ( .A(get_rx_data), .B(n2383), .Y(n2457) );
  OAI21X1 U2746 ( .A(n2467), .B(n2468), .C(n2469), .Y(\next_slavedata[13][7] )
         );
  AOI22X1 U2747 ( .A(\slavedata[13][7] ), .B(n2470), .C(n2471), .D(n2472), .Y(
        n2469) );
  INVX1 U2748 ( .A(n2473), .Y(n2468) );
  OAI21X1 U2749 ( .A(n2467), .B(n2474), .C(n2475), .Y(\next_slavedata[13][6] )
         );
  AOI22X1 U2750 ( .A(\slavedata[13][6] ), .B(n2470), .C(n2471), .D(n2476), .Y(
        n2475) );
  INVX1 U2751 ( .A(n2477), .Y(n2474) );
  OAI21X1 U2752 ( .A(n2467), .B(n2478), .C(n2479), .Y(\next_slavedata[13][5] )
         );
  AOI22X1 U2753 ( .A(\slavedata[13][5] ), .B(n2470), .C(n2471), .D(n2480), .Y(
        n2479) );
  INVX1 U2754 ( .A(n2481), .Y(n2478) );
  OAI21X1 U2755 ( .A(n2467), .B(n2482), .C(n2483), .Y(\next_slavedata[13][4] )
         );
  AOI22X1 U2756 ( .A(\slavedata[13][4] ), .B(n2470), .C(n2471), .D(n2484), .Y(
        n2483) );
  INVX1 U2757 ( .A(n2485), .Y(n2482) );
  OAI21X1 U2758 ( .A(n2467), .B(n2486), .C(n2487), .Y(\next_slavedata[13][3] )
         );
  AOI22X1 U2759 ( .A(\slavedata[13][3] ), .B(n2470), .C(n2471), .D(n2488), .Y(
        n2487) );
  INVX1 U2760 ( .A(n2489), .Y(n2486) );
  OAI21X1 U2761 ( .A(n2467), .B(n2490), .C(n2491), .Y(\next_slavedata[13][2] )
         );
  AOI22X1 U2762 ( .A(\slavedata[13][2] ), .B(n2470), .C(n2471), .D(n2492), .Y(
        n2491) );
  INVX1 U2763 ( .A(n2493), .Y(n2490) );
  OAI21X1 U2764 ( .A(n2467), .B(n2494), .C(n2495), .Y(\next_slavedata[13][1] )
         );
  AOI22X1 U2765 ( .A(\slavedata[13][1] ), .B(n2470), .C(n2471), .D(n2496), .Y(
        n2495) );
  INVX1 U2766 ( .A(n2497), .Y(n2494) );
  OAI21X1 U2767 ( .A(n2467), .B(n2498), .C(n2499), .Y(\next_slavedata[13][0] )
         );
  AOI22X1 U2768 ( .A(clear), .B(n2470), .C(n2471), .D(n2500), .Y(n2499) );
  AND2X1 U2769 ( .A(n2501), .B(n2502), .Y(n2471) );
  AOI21X1 U2770 ( .A(flush_state[1]), .B(flush_state[0]), .C(n2503), .Y(n2470)
         );
  NOR2X1 U2771 ( .A(n2504), .B(n2505), .Y(n2503) );
  AOI21X1 U2772 ( .A(n2506), .B(next_hsize), .C(n2501), .Y(n2505) );
  INVX1 U2773 ( .A(n2507), .Y(n2498) );
  NAND2X1 U2774 ( .A(next_hsize), .B(n2506), .Y(n2467) );
  NOR2X1 U2775 ( .A(n2501), .B(n2151), .Y(n2506) );
  OAI22X1 U2776 ( .A(n2509), .B(n2510), .C(n2511), .D(n2512), .Y(
        \next_slavedata[12][7] ) );
  INVX1 U2777 ( .A(\slavedata[12][7] ), .Y(n2510) );
  OAI22X1 U2778 ( .A(n2509), .B(n2513), .C(n2514), .D(n2512), .Y(
        \next_slavedata[12][6] ) );
  INVX1 U2779 ( .A(\slavedata[12][6] ), .Y(n2513) );
  OAI22X1 U2780 ( .A(n2509), .B(n2515), .C(n2516), .D(n2512), .Y(
        \next_slavedata[12][5] ) );
  OAI22X1 U2781 ( .A(n2509), .B(n2517), .C(n2518), .D(n2512), .Y(
        \next_slavedata[12][4] ) );
  INVX1 U2782 ( .A(\slavedata[12][4] ), .Y(n2517) );
  OAI22X1 U2783 ( .A(n2509), .B(n2519), .C(n2520), .D(n2512), .Y(
        \next_slavedata[12][3] ) );
  INVX1 U2784 ( .A(\slavedata[12][3] ), .Y(n2519) );
  OAI22X1 U2785 ( .A(n2521), .B(n2509), .C(n2522), .D(n2512), .Y(
        \next_slavedata[12][2] ) );
  INVX1 U2786 ( .A(\slavedata[12][2] ), .Y(n2521) );
  OAI22X1 U2787 ( .A(n2372), .B(n2509), .C(n2523), .D(n2512), .Y(
        \next_slavedata[12][1] ) );
  INVX1 U2788 ( .A(\slavedata[12][1] ), .Y(n2372) );
  OAI22X1 U2789 ( .A(n2376), .B(n2509), .C(n2524), .D(n2512), .Y(
        \next_slavedata[12][0] ) );
  OR2X1 U2790 ( .A(n2525), .B(n2526), .Y(n2512) );
  OAI22X1 U2791 ( .A(n2527), .B(n2528), .C(n2504), .D(n2525), .Y(n2509) );
  INVX1 U2792 ( .A(\slavedata[12][0] ), .Y(n2376) );
  OAI21X1 U2793 ( .A(n2529), .B(n2530), .C(n2531), .Y(\next_slavedata[11][7] )
         );
  AOI22X1 U2794 ( .A(n2532), .B(n2472), .C(n2533), .D(n2473), .Y(n2531) );
  NOR2X1 U2795 ( .A(n2526), .B(n2534), .Y(n2473) );
  AOI22X1 U2796 ( .A(hwdata[31]), .B(n2151), .C(n2535), .D(hwdata[15]), .Y(
        n2534) );
  OAI21X1 U2797 ( .A(n2529), .B(n2536), .C(n2537), .Y(\next_slavedata[11][6] )
         );
  AOI22X1 U2798 ( .A(n2532), .B(n2476), .C(n2533), .D(n2477), .Y(n2537) );
  NOR2X1 U2799 ( .A(n2526), .B(n2538), .Y(n2477) );
  AOI22X1 U2800 ( .A(hwdata[30]), .B(n2151), .C(n2535), .D(hwdata[14]), .Y(
        n2538) );
  OAI21X1 U2801 ( .A(n2529), .B(n2539), .C(n2540), .Y(\next_slavedata[11][5] )
         );
  AOI22X1 U2802 ( .A(n2532), .B(n2480), .C(n2533), .D(n2481), .Y(n2540) );
  NOR2X1 U2803 ( .A(n2526), .B(n2541), .Y(n2481) );
  AOI22X1 U2804 ( .A(hwdata[29]), .B(n2151), .C(n2535), .D(hwdata[13]), .Y(
        n2541) );
  OAI21X1 U2805 ( .A(n2529), .B(n2542), .C(n2543), .Y(\next_slavedata[11][4] )
         );
  AOI22X1 U2806 ( .A(n2532), .B(n2484), .C(n2533), .D(n2485), .Y(n2543) );
  NOR2X1 U2807 ( .A(n2526), .B(n2544), .Y(n2485) );
  AOI22X1 U2808 ( .A(hwdata[28]), .B(n2151), .C(n2535), .D(hwdata[12]), .Y(
        n2544) );
  OAI21X1 U2809 ( .A(n2529), .B(n2545), .C(n2546), .Y(\next_slavedata[11][3] )
         );
  AOI22X1 U2810 ( .A(n2532), .B(n2488), .C(n2533), .D(n2489), .Y(n2546) );
  NOR2X1 U2811 ( .A(n2526), .B(n2547), .Y(n2489) );
  AOI22X1 U2812 ( .A(hwdata[27]), .B(n2151), .C(n2535), .D(hwdata[11]), .Y(
        n2547) );
  NAND2X1 U2813 ( .A(n2548), .B(n2549), .Y(\next_slavedata[11][2] ) );
  AOI22X1 U2814 ( .A(n2532), .B(n2492), .C(n2533), .D(n2493), .Y(n2549) );
  NOR2X1 U2815 ( .A(n2526), .B(n2550), .Y(n2493) );
  AOI22X1 U2816 ( .A(hwdata[26]), .B(n2151), .C(n2535), .D(hwdata[10]), .Y(
        n2550) );
  AOI22X1 U2817 ( .A(n2551), .B(n2552), .C(\slavedata[11][2] ), .D(n2553), .Y(
        n2548) );
  NAND2X1 U2818 ( .A(n2554), .B(n2555), .Y(\next_slavedata[11][1] ) );
  AOI22X1 U2819 ( .A(n2532), .B(n2496), .C(n2533), .D(n2497), .Y(n2555) );
  NOR2X1 U2820 ( .A(n2526), .B(n2556), .Y(n2497) );
  AOI22X1 U2821 ( .A(n2535), .B(hwdata[9]), .C(hwdata[25]), .D(n2151), .Y(
        n2556) );
  AOI22X1 U2822 ( .A(n2557), .B(n2552), .C(\slavedata[11][1] ), .D(n2553), .Y(
        n2554) );
  NAND2X1 U2823 ( .A(n2558), .B(n2559), .Y(\next_slavedata[11][0] ) );
  AOI22X1 U2824 ( .A(n2532), .B(n2500), .C(n2533), .D(n2507), .Y(n2559) );
  NOR2X1 U2825 ( .A(n2526), .B(n2560), .Y(n2507) );
  AOI22X1 U2826 ( .A(n2535), .B(hwdata[8]), .C(hwdata[24]), .D(n2151), .Y(
        n2560) );
  AND2X1 U2827 ( .A(n2561), .B(n2502), .Y(n2532) );
  AOI22X1 U2828 ( .A(n2562), .B(n2552), .C(\slavedata[11][0] ), .D(n2553), .Y(
        n2558) );
  INVX1 U2829 ( .A(n2529), .Y(n2553) );
  NAND2X1 U2830 ( .A(n2563), .B(n2564), .Y(n2529) );
  OAI21X1 U2831 ( .A(n2551), .B(n2565), .C(n2566), .Y(n2563) );
  INVX1 U2832 ( .A(n2567), .Y(n2565) );
  AND2X1 U2833 ( .A(n2566), .B(n2564), .Y(n2552) );
  OAI21X1 U2834 ( .A(n2561), .B(n2533), .C(n2568), .Y(n2564) );
  INVX1 U2835 ( .A(n2504), .Y(n2568) );
  NOR2X1 U2836 ( .A(n2569), .B(addr[2]), .Y(n2533) );
  AND2X1 U2837 ( .A(n2570), .B(n2571), .Y(n2561) );
  INVX1 U2838 ( .A(n2572), .Y(n2566) );
  OAI21X1 U2839 ( .A(htrans[1]), .B(htrans[0]), .C(hsel), .Y(n2572) );
  OAI22X1 U2840 ( .A(n2511), .B(n2573), .C(n2574), .D(n2575), .Y(
        \next_slavedata[10][7] ) );
  INVX1 U2841 ( .A(\slavedata[10][7] ), .Y(n2575) );
  INVX1 U2842 ( .A(n2472), .Y(n2511) );
  NAND2X1 U2843 ( .A(n2576), .B(n2577), .Y(n2472) );
  AOI22X1 U2844 ( .A(n2578), .B(hwdata[31]), .C(n2579), .D(hwdata[15]), .Y(
        n2577) );
  AOI22X1 U2845 ( .A(hwdata[7]), .B(n2580), .C(n2151), .D(hwdata[23]), .Y(
        n2576) );
  OAI22X1 U2846 ( .A(n2514), .B(n2573), .C(n2574), .D(n2581), .Y(
        \next_slavedata[10][6] ) );
  INVX1 U2847 ( .A(\slavedata[10][6] ), .Y(n2581) );
  INVX1 U2848 ( .A(n2476), .Y(n2514) );
  NAND2X1 U2849 ( .A(n2582), .B(n2583), .Y(n2476) );
  AOI22X1 U2850 ( .A(n2578), .B(hwdata[30]), .C(n2579), .D(hwdata[14]), .Y(
        n2583) );
  AOI22X1 U2851 ( .A(hwdata[6]), .B(n2580), .C(n2151), .D(hwdata[22]), .Y(
        n2582) );
  OAI22X1 U2852 ( .A(n2516), .B(n2573), .C(n2574), .D(n2584), .Y(
        \next_slavedata[10][5] ) );
  INVX1 U2853 ( .A(\slavedata[10][5] ), .Y(n2584) );
  INVX1 U2854 ( .A(n2480), .Y(n2516) );
  NAND2X1 U2855 ( .A(n2585), .B(n2586), .Y(n2480) );
  AOI22X1 U2856 ( .A(n2578), .B(hwdata[29]), .C(n2579), .D(hwdata[13]), .Y(
        n2586) );
  AOI22X1 U2857 ( .A(hwdata[5]), .B(n2580), .C(n2151), .D(hwdata[21]), .Y(
        n2585) );
  OAI22X1 U2858 ( .A(n2518), .B(n2573), .C(n2574), .D(n2587), .Y(
        \next_slavedata[10][4] ) );
  INVX1 U2859 ( .A(\slavedata[10][4] ), .Y(n2587) );
  INVX1 U2860 ( .A(n2484), .Y(n2518) );
  NAND2X1 U2861 ( .A(n2588), .B(n2589), .Y(n2484) );
  AOI22X1 U2862 ( .A(n2578), .B(hwdata[28]), .C(n2579), .D(hwdata[12]), .Y(
        n2589) );
  AOI22X1 U2863 ( .A(hwdata[4]), .B(n2580), .C(n2151), .D(hwdata[20]), .Y(
        n2588) );
  OAI22X1 U2864 ( .A(n2520), .B(n2573), .C(n2574), .D(n2590), .Y(
        \next_slavedata[10][3] ) );
  INVX1 U2865 ( .A(\slavedata[10][3] ), .Y(n2590) );
  INVX1 U2866 ( .A(n2488), .Y(n2520) );
  NAND2X1 U2867 ( .A(n2591), .B(n2592), .Y(n2488) );
  AOI22X1 U2868 ( .A(n2578), .B(hwdata[27]), .C(n2579), .D(hwdata[11]), .Y(
        n2592) );
  AOI22X1 U2869 ( .A(hwdata[3]), .B(n2580), .C(n2151), .D(hwdata[19]), .Y(
        n2591) );
  OAI22X1 U2870 ( .A(n2522), .B(n2573), .C(n2574), .D(n2593), .Y(
        \next_slavedata[10][2] ) );
  INVX1 U2871 ( .A(\slavedata[10][2] ), .Y(n2593) );
  INVX1 U2872 ( .A(n2492), .Y(n2522) );
  NAND2X1 U2873 ( .A(n2594), .B(n2595), .Y(n2492) );
  AOI22X1 U2874 ( .A(n2578), .B(hwdata[26]), .C(n2579), .D(hwdata[10]), .Y(
        n2595) );
  AOI22X1 U2875 ( .A(hwdata[2]), .B(n2580), .C(n2151), .D(hwdata[18]), .Y(
        n2594) );
  OAI22X1 U2876 ( .A(n2523), .B(n2573), .C(n2574), .D(n2596), .Y(
        \next_slavedata[10][1] ) );
  INVX1 U2877 ( .A(\slavedata[10][1] ), .Y(n2596) );
  INVX1 U2878 ( .A(n2496), .Y(n2523) );
  NAND2X1 U2879 ( .A(n2597), .B(n2598), .Y(n2496) );
  AOI22X1 U2880 ( .A(n2578), .B(hwdata[25]), .C(n2579), .D(hwdata[9]), .Y(
        n2598) );
  AOI22X1 U2881 ( .A(hwdata[1]), .B(n2580), .C(n2151), .D(hwdata[17]), .Y(
        n2597) );
  OAI21X1 U2882 ( .A(n2428), .B(n2599), .C(n2600), .Y(\next_slavedata[0][7] )
         );
  AOI22X1 U2883 ( .A(hwdata[7]), .B(n2430), .C(n2601), .D(\slavedata[0][7] ), 
        .Y(n2600) );
  INVX1 U2884 ( .A(rx_data[7]), .Y(n2428) );
  OAI21X1 U2885 ( .A(n2432), .B(n2599), .C(n2602), .Y(\next_slavedata[0][6] )
         );
  AOI22X1 U2886 ( .A(hwdata[6]), .B(n2430), .C(n2601), .D(\slavedata[0][6] ), 
        .Y(n2602) );
  INVX1 U2887 ( .A(rx_data[6]), .Y(n2432) );
  OAI21X1 U2888 ( .A(n2434), .B(n2599), .C(n2603), .Y(\next_slavedata[0][5] )
         );
  AOI22X1 U2889 ( .A(hwdata[5]), .B(n2430), .C(n2601), .D(\slavedata[0][5] ), 
        .Y(n2603) );
  INVX1 U2890 ( .A(rx_data[5]), .Y(n2434) );
  OAI21X1 U2891 ( .A(n2436), .B(n2599), .C(n2604), .Y(\next_slavedata[0][4] )
         );
  AOI22X1 U2892 ( .A(hwdata[4]), .B(n2430), .C(n2601), .D(\slavedata[0][4] ), 
        .Y(n2604) );
  INVX1 U2893 ( .A(rx_data[4]), .Y(n2436) );
  OAI21X1 U2894 ( .A(n2438), .B(n2599), .C(n2605), .Y(\next_slavedata[0][3] )
         );
  AOI22X1 U2895 ( .A(hwdata[3]), .B(n2430), .C(n2601), .D(\slavedata[0][3] ), 
        .Y(n2605) );
  INVX1 U2896 ( .A(rx_data[3]), .Y(n2438) );
  OAI21X1 U2897 ( .A(n2440), .B(n2599), .C(n2606), .Y(\next_slavedata[0][2] )
         );
  AOI22X1 U2898 ( .A(hwdata[2]), .B(n2430), .C(n2601), .D(\slavedata[0][2] ), 
        .Y(n2606) );
  INVX1 U2899 ( .A(rx_data[2]), .Y(n2440) );
  OAI21X1 U2900 ( .A(n2442), .B(n2599), .C(n2607), .Y(\next_slavedata[0][1] )
         );
  AOI22X1 U2901 ( .A(hwdata[1]), .B(n2430), .C(n2601), .D(\slavedata[0][1] ), 
        .Y(n2607) );
  INVX1 U2902 ( .A(rx_data[1]), .Y(n2442) );
  OAI21X1 U2903 ( .A(n2444), .B(n2599), .C(n2608), .Y(\next_slavedata[0][0] )
         );
  AOI22X1 U2904 ( .A(hwdata[0]), .B(n2430), .C(n2601), .D(\slavedata[0][0] ), 
        .Y(n2608) );
  AND2X1 U2905 ( .A(n2599), .B(n2446), .Y(n2601) );
  NAND2X1 U2906 ( .A(get_rx_data), .B(n2385), .Y(n2599) );
  INVX1 U2907 ( .A(n2609), .Y(n2385) );
  INVX1 U2908 ( .A(rx_data[0]), .Y(n2444) );
  NAND2X1 U2909 ( .A(n2610), .B(n2611), .Y(next_hrdata[9]) );
  AOI22X1 U2910 ( .A(N1562), .B(n2612), .C(N1540), .D(n2613), .Y(n2611) );
  AOI22X1 U2911 ( .A(n2150), .B(hwdata[9]), .C(hrdata[9]), .D(n2152), .Y(n2610) );
  NAND2X1 U2912 ( .A(n2616), .B(n2617), .Y(next_hrdata[8]) );
  AOI22X1 U2913 ( .A(N1563), .B(n2612), .C(N1541), .D(n2613), .Y(n2617) );
  AOI22X1 U2914 ( .A(n2150), .B(hwdata[8]), .C(hrdata[8]), .D(n2152), .Y(n2616) );
  OAI21X1 U2915 ( .A(n2618), .B(n2619), .C(n2620), .Y(next_hrdata[7]) );
  AOI22X1 U2916 ( .A(n2150), .B(hwdata[7]), .C(N1556), .D(n2621), .Y(n2620) );
  INVX1 U2917 ( .A(hrdata[7]), .Y(n2619) );
  OAI21X1 U2918 ( .A(n2618), .B(n2622), .C(n2623), .Y(next_hrdata[6]) );
  AOI22X1 U2919 ( .A(n2150), .B(hwdata[6]), .C(N1557), .D(n2621), .Y(n2623) );
  INVX1 U2920 ( .A(hrdata[6]), .Y(n2622) );
  OAI21X1 U2921 ( .A(n2618), .B(n2624), .C(n2625), .Y(next_hrdata[5]) );
  AOI22X1 U2922 ( .A(n2150), .B(hwdata[5]), .C(N1558), .D(n2621), .Y(n2625) );
  INVX1 U2923 ( .A(hrdata[5]), .Y(n2624) );
  OAI21X1 U2924 ( .A(n2618), .B(n2626), .C(n2627), .Y(next_hrdata[4]) );
  AOI22X1 U2925 ( .A(n2150), .B(hwdata[4]), .C(N1559), .D(n2621), .Y(n2627) );
  INVX1 U2926 ( .A(hrdata[4]), .Y(n2626) );
  OAI21X1 U2927 ( .A(n2618), .B(n2628), .C(n2629), .Y(next_hrdata[3]) );
  AOI22X1 U2928 ( .A(n2150), .B(hwdata[3]), .C(N1560), .D(n2621), .Y(n2629) );
  INVX1 U2929 ( .A(hrdata[3]), .Y(n2628) );
  NAND3X1 U2930 ( .A(n2630), .B(n2631), .C(n2632), .Y(next_hrdata[31]) );
  NOR2X1 U2931 ( .A(n2633), .B(n2634), .Y(n2632) );
  INVX1 U2932 ( .A(\slavedata[11][7] ), .Y(n2530) );
  INVX1 U2933 ( .A(n2638), .Y(n2633) );
  AOI22X1 U2934 ( .A(\slavedata[13][7] ), .B(n2639), .C(\slavedata[3][7] ), 
        .D(n2640), .Y(n2638) );
  AOI22X1 U2935 ( .A(N1534), .B(n2641), .C(n2642), .D(N1556), .Y(n2631) );
  AOI22X1 U2936 ( .A(n2150), .B(hwdata[31]), .C(hrdata[31]), .D(n2152), .Y(
        n2630) );
  NAND3X1 U2937 ( .A(n2643), .B(n2644), .C(n2645), .Y(next_hrdata[30]) );
  NOR2X1 U2938 ( .A(n2646), .B(n2647), .Y(n2645) );
  INVX1 U2939 ( .A(\slavedata[11][6] ), .Y(n2536) );
  INVX1 U2940 ( .A(n2649), .Y(n2646) );
  AOI22X1 U2941 ( .A(\slavedata[13][6] ), .B(n2639), .C(\slavedata[3][6] ), 
        .D(n2640), .Y(n2649) );
  AOI22X1 U2942 ( .A(N1535), .B(n2641), .C(n2642), .D(N1557), .Y(n2644) );
  AOI22X1 U2943 ( .A(n2150), .B(hwdata[30]), .C(hrdata[30]), .D(n2152), .Y(
        n2643) );
  OAI21X1 U2944 ( .A(n2618), .B(n2650), .C(n2651), .Y(next_hrdata[2]) );
  AOI22X1 U2945 ( .A(n2150), .B(hwdata[2]), .C(N1561), .D(n2621), .Y(n2651) );
  INVX1 U2946 ( .A(hrdata[2]), .Y(n2650) );
  NAND3X1 U2947 ( .A(n2652), .B(n2653), .C(n2654), .Y(next_hrdata[29]) );
  NOR2X1 U2948 ( .A(n2655), .B(n2656), .Y(n2654) );
  INVX1 U2949 ( .A(\slavedata[11][5] ), .Y(n2539) );
  INVX1 U2950 ( .A(n2658), .Y(n2655) );
  AOI22X1 U2951 ( .A(\slavedata[13][5] ), .B(n2639), .C(\slavedata[3][5] ), 
        .D(n2640), .Y(n2658) );
  AOI22X1 U2952 ( .A(N1536), .B(n2641), .C(n2642), .D(N1558), .Y(n2653) );
  AOI22X1 U2953 ( .A(n2150), .B(hwdata[29]), .C(hrdata[29]), .D(n2152), .Y(
        n2652) );
  NAND3X1 U2954 ( .A(n2659), .B(n2660), .C(n2661), .Y(next_hrdata[28]) );
  NOR2X1 U2955 ( .A(n2662), .B(n2663), .Y(n2661) );
  INVX1 U2956 ( .A(\slavedata[11][4] ), .Y(n2542) );
  INVX1 U2957 ( .A(n2665), .Y(n2662) );
  AOI22X1 U2958 ( .A(\slavedata[13][4] ), .B(n2639), .C(\slavedata[3][4] ), 
        .D(n2640), .Y(n2665) );
  AOI22X1 U2959 ( .A(N1537), .B(n2641), .C(n2642), .D(N1559), .Y(n2660) );
  AOI22X1 U2960 ( .A(n2150), .B(hwdata[28]), .C(hrdata[28]), .D(n2152), .Y(
        n2659) );
  NAND3X1 U2961 ( .A(n2666), .B(n2667), .C(n2668), .Y(next_hrdata[27]) );
  NOR2X1 U2962 ( .A(n2669), .B(n2670), .Y(n2668) );
  INVX1 U2963 ( .A(\slavedata[11][3] ), .Y(n2545) );
  INVX1 U2964 ( .A(n2672), .Y(n2669) );
  AOI22X1 U2965 ( .A(\slavedata[13][3] ), .B(n2639), .C(\slavedata[3][3] ), 
        .D(n2640), .Y(n2672) );
  AOI22X1 U2966 ( .A(N1538), .B(n2641), .C(n2642), .D(N1560), .Y(n2667) );
  AOI22X1 U2967 ( .A(n2150), .B(hwdata[27]), .C(hrdata[27]), .D(n2615), .Y(
        n2666) );
  NAND3X1 U2968 ( .A(n2673), .B(n2674), .C(n2675), .Y(next_hrdata[26]) );
  NOR2X1 U2969 ( .A(n2676), .B(n2677), .Y(n2675) );
  INVX1 U2970 ( .A(\slavedata[11][2] ), .Y(n2678) );
  INVX1 U2971 ( .A(n2680), .Y(n2676) );
  AOI22X1 U2972 ( .A(\slavedata[13][2] ), .B(n2639), .C(\slavedata[3][2] ), 
        .D(n2640), .Y(n2680) );
  AOI22X1 U2973 ( .A(N1539), .B(n2641), .C(N1561), .D(n2642), .Y(n2674) );
  AOI22X1 U2974 ( .A(n2150), .B(hwdata[26]), .C(hrdata[26]), .D(n2615), .Y(
        n2673) );
  NAND3X1 U2975 ( .A(n2681), .B(n2682), .C(n2683), .Y(next_hrdata[25]) );
  NOR2X1 U2976 ( .A(n2684), .B(n2685), .Y(n2683) );
  INVX1 U2977 ( .A(n2688), .Y(n2684) );
  AOI22X1 U2978 ( .A(\slavedata[13][1] ), .B(n2639), .C(\slavedata[3][1] ), 
        .D(n2640), .Y(n2688) );
  AOI22X1 U2979 ( .A(n2641), .B(N1540), .C(n2642), .D(N1562), .Y(n2682) );
  AOI22X1 U2980 ( .A(n2150), .B(hwdata[25]), .C(hrdata[25]), .D(n2615), .Y(
        n2681) );
  NAND3X1 U2981 ( .A(n2689), .B(n2690), .C(n2691), .Y(next_hrdata[24]) );
  NOR2X1 U2982 ( .A(n2692), .B(n2693), .Y(n2691) );
  OAI21X1 U2983 ( .A(n2694), .B(n2635), .C(n2695), .Y(n2693) );
  NAND2X1 U2984 ( .A(\slavedata[7][0] ), .B(n2637), .Y(n2695) );
  INVX1 U2985 ( .A(\slavedata[11][0] ), .Y(n2694) );
  INVX1 U2986 ( .A(n2696), .Y(n2692) );
  AOI22X1 U2987 ( .A(clear), .B(n2639), .C(\slavedata[3][0] ), .D(n2640), .Y(
        n2696) );
  AOI22X1 U2988 ( .A(n2641), .B(N1541), .C(n2642), .D(N1563), .Y(n2690) );
  NOR2X1 U2989 ( .A(n2697), .B(n2410), .Y(n2642) );
  INVX1 U2990 ( .A(n2698), .Y(n2641) );
  AOI22X1 U2991 ( .A(n2150), .B(hwdata[24]), .C(hrdata[24]), .D(n2615), .Y(
        n2689) );
  NAND3X1 U2992 ( .A(n2699), .B(n2700), .C(n2701), .Y(next_hrdata[23]) );
  AOI21X1 U2993 ( .A(hrdata[23]), .B(n2152), .C(n2702), .Y(n2701) );
  INVX1 U2994 ( .A(n2703), .Y(n2702) );
  AOI22X1 U2995 ( .A(hwdata[23]), .B(n2614), .C(n2704), .D(N1556), .Y(n2703)
         );
  AOI22X1 U2996 ( .A(n2640), .B(\slavedata[2][7] ), .C(n2639), .D(
        \slavedata[12][7] ), .Y(n2700) );
  NAND3X1 U2997 ( .A(n2706), .B(n2707), .C(n2708), .Y(next_hrdata[22]) );
  AOI21X1 U2998 ( .A(hrdata[22]), .B(n2152), .C(n2709), .Y(n2708) );
  INVX1 U2999 ( .A(n2710), .Y(n2709) );
  AOI22X1 U3000 ( .A(hwdata[22]), .B(n2614), .C(n2704), .D(N1557), .Y(n2710)
         );
  AOI22X1 U3001 ( .A(n2640), .B(\slavedata[2][6] ), .C(n2639), .D(
        \slavedata[12][6] ), .Y(n2707) );
  NAND3X1 U3002 ( .A(n2711), .B(n2712), .C(n2713), .Y(next_hrdata[21]) );
  AOI21X1 U3003 ( .A(hrdata[21]), .B(n2152), .C(n2714), .Y(n2713) );
  INVX1 U3004 ( .A(n2715), .Y(n2714) );
  AOI22X1 U3005 ( .A(hwdata[21]), .B(n2614), .C(n2704), .D(N1558), .Y(n2715)
         );
  AOI22X1 U3006 ( .A(n2640), .B(\slavedata[2][5] ), .C(n2639), .D(
        \slavedata[12][5] ), .Y(n2712) );
  NAND3X1 U3007 ( .A(n2716), .B(n2717), .C(n2718), .Y(next_hrdata[20]) );
  AOI21X1 U3008 ( .A(hrdata[20]), .B(n2152), .C(n2719), .Y(n2718) );
  INVX1 U3009 ( .A(n2720), .Y(n2719) );
  AOI22X1 U3010 ( .A(hwdata[20]), .B(n2614), .C(n2704), .D(N1559), .Y(n2720)
         );
  AOI22X1 U3011 ( .A(n2640), .B(\slavedata[2][4] ), .C(n2639), .D(
        \slavedata[12][4] ), .Y(n2717) );
  OAI21X1 U3012 ( .A(n2618), .B(n2721), .C(n2722), .Y(next_hrdata[1]) );
  AOI22X1 U3013 ( .A(n2150), .B(hwdata[1]), .C(n2621), .D(N1562), .Y(n2722) );
  INVX1 U3014 ( .A(hrdata[1]), .Y(n2721) );
  NAND3X1 U3015 ( .A(n2723), .B(n2724), .C(n2725), .Y(next_hrdata[19]) );
  AOI21X1 U3016 ( .A(hrdata[19]), .B(n2152), .C(n2726), .Y(n2725) );
  INVX1 U3017 ( .A(n2727), .Y(n2726) );
  AOI22X1 U3018 ( .A(hwdata[19]), .B(n2614), .C(n2704), .D(N1560), .Y(n2727)
         );
  AOI22X1 U3019 ( .A(n2640), .B(\slavedata[2][3] ), .C(n2639), .D(
        \slavedata[12][3] ), .Y(n2724) );
  NAND3X1 U3020 ( .A(n2728), .B(n2729), .C(n2730), .Y(next_hrdata[18]) );
  AOI21X1 U3021 ( .A(hrdata[18]), .B(n2152), .C(n2731), .Y(n2730) );
  INVX1 U3022 ( .A(n2732), .Y(n2731) );
  AOI22X1 U3023 ( .A(hwdata[18]), .B(n2614), .C(n2704), .D(N1561), .Y(n2732)
         );
  AOI22X1 U3024 ( .A(n2640), .B(\slavedata[2][2] ), .C(n2639), .D(
        \slavedata[12][2] ), .Y(n2729) );
  NAND3X1 U3025 ( .A(n2733), .B(n2734), .C(n2735), .Y(next_hrdata[17]) );
  AOI21X1 U3026 ( .A(hrdata[17]), .B(n2152), .C(n2736), .Y(n2735) );
  INVX1 U3027 ( .A(n2737), .Y(n2736) );
  AOI22X1 U3028 ( .A(hwdata[17]), .B(n2614), .C(n2704), .D(N1562), .Y(n2737)
         );
  AOI22X1 U3029 ( .A(n2640), .B(\slavedata[2][1] ), .C(n2639), .D(
        \slavedata[12][1] ), .Y(n2734) );
  NAND3X1 U3030 ( .A(n2738), .B(n2739), .C(n2740), .Y(next_hrdata[16]) );
  AOI21X1 U3031 ( .A(hrdata[16]), .B(n2152), .C(n2741), .Y(n2740) );
  INVX1 U3032 ( .A(n2742), .Y(n2741) );
  AOI22X1 U3033 ( .A(hwdata[16]), .B(n2614), .C(n2704), .D(N1563), .Y(n2742)
         );
  OAI21X1 U3034 ( .A(haddr[0]), .B(n2697), .C(n2698), .Y(n2704) );
  NAND3X1 U3035 ( .A(n2557), .B(haddr[1]), .C(n2743), .Y(n2698) );
  NAND3X1 U3036 ( .A(n2562), .B(haddr[1]), .C(n2743), .Y(n2697) );
  AOI22X1 U3037 ( .A(n2640), .B(\slavedata[2][0] ), .C(n2639), .D(
        \slavedata[12][0] ), .Y(n2739) );
  NAND3X1 U3038 ( .A(n2834), .B(n2745), .C(n2835), .Y(n2744) );
  NAND3X1 U3039 ( .A(n2747), .B(n2748), .C(n2745), .Y(n2746) );
  AOI22X1 U3040 ( .A(n2705), .B(\slavedata[10][0] ), .C(\slavedata[6][0] ), 
        .D(n2637), .Y(n2738) );
  AND2X1 U3041 ( .A(n2834), .B(n2745), .Y(n2637) );
  INVX1 U3042 ( .A(n2635), .Y(n2705) );
  NAND2X1 U3043 ( .A(n2835), .B(n2745), .Y(n2635) );
  AND2X1 U3044 ( .A(n2743), .B(n2551), .Y(n2745) );
  NAND2X1 U3045 ( .A(n2749), .B(n2750), .Y(next_hrdata[15]) );
  AOI22X1 U3046 ( .A(N1556), .B(n2612), .C(N1534), .D(n2613), .Y(n2750) );
  AOI22X1 U3047 ( .A(n2150), .B(hwdata[15]), .C(hrdata[15]), .D(n2615), .Y(
        n2749) );
  NAND2X1 U3048 ( .A(n2751), .B(n2752), .Y(next_hrdata[14]) );
  AOI22X1 U3049 ( .A(N1557), .B(n2612), .C(N1535), .D(n2613), .Y(n2752) );
  AOI22X1 U3050 ( .A(n2150), .B(hwdata[14]), .C(hrdata[14]), .D(n2615), .Y(
        n2751) );
  NAND2X1 U3051 ( .A(n2753), .B(n2754), .Y(next_hrdata[13]) );
  AOI22X1 U3052 ( .A(N1558), .B(n2612), .C(N1536), .D(n2613), .Y(n2754) );
  AOI22X1 U3053 ( .A(n2150), .B(hwdata[13]), .C(hrdata[13]), .D(n2615), .Y(
        n2753) );
  NAND2X1 U3054 ( .A(n2755), .B(n2756), .Y(next_hrdata[12]) );
  AOI22X1 U3055 ( .A(N1559), .B(n2612), .C(N1537), .D(n2613), .Y(n2756) );
  AOI22X1 U3056 ( .A(n2150), .B(hwdata[12]), .C(hrdata[12]), .D(n2615), .Y(
        n2755) );
  NAND2X1 U3057 ( .A(n2757), .B(n2758), .Y(next_hrdata[11]) );
  AOI22X1 U3058 ( .A(N1560), .B(n2612), .C(N1538), .D(n2613), .Y(n2758) );
  AOI22X1 U3059 ( .A(n2614), .B(hwdata[11]), .C(hrdata[11]), .D(n2615), .Y(
        n2757) );
  NAND2X1 U3060 ( .A(n2759), .B(n2760), .Y(next_hrdata[10]) );
  AOI22X1 U3061 ( .A(N1561), .B(n2612), .C(N1539), .D(n2613), .Y(n2760) );
  AND2X1 U3062 ( .A(n2743), .B(n2761), .Y(n2613) );
  INVX1 U3063 ( .A(n2762), .Y(n2612) );
  NAND3X1 U3064 ( .A(n2743), .B(n2562), .C(n2763), .Y(n2762) );
  NOR2X1 U3065 ( .A(haddr[1]), .B(n2410), .Y(n2763) );
  INVX1 U3066 ( .A(haddr[0]), .Y(n2410) );
  AOI22X1 U3067 ( .A(n2614), .B(hwdata[10]), .C(hrdata[10]), .D(n2615), .Y(
        n2759) );
  OAI21X1 U3068 ( .A(n2618), .B(n2764), .C(n2765), .Y(next_hrdata[0]) );
  AOI22X1 U3069 ( .A(n2614), .B(hwdata[0]), .C(n2621), .D(N1563), .Y(n2765) );
  INVX1 U3070 ( .A(n2766), .Y(n2621) );
  OAI21X1 U3071 ( .A(n2767), .B(n2761), .C(n2743), .Y(n2766) );
  AND2X1 U3072 ( .A(n2618), .B(n2768), .Y(n2743) );
  INVX1 U3073 ( .A(n2769), .Y(n2761) );
  AOI21X1 U3074 ( .A(n2770), .B(n2557), .C(n2551), .Y(n2769) );
  NOR2X1 U3075 ( .A(n2771), .B(hsize[0]), .Y(n2551) );
  NOR2X1 U3076 ( .A(haddr[0]), .B(haddr[1]), .Y(n2767) );
  NOR2X1 U3077 ( .A(n2768), .B(n2152), .Y(n2614) );
  NAND3X1 U3078 ( .A(n2772), .B(n2773), .C(n2774), .Y(n2768) );
  NOR2X1 U3079 ( .A(n2775), .B(n2776), .Y(n2774) );
  XOR2X1 U3080 ( .A(next_haddr[3]), .B(haddr[3]), .Y(n2776) );
  XOR2X1 U3081 ( .A(next_haddr[2]), .B(haddr[2]), .Y(n2775) );
  XNOR2X1 U3082 ( .A(haddr[0]), .B(next_haddr[0]), .Y(n2773) );
  NOR2X1 U3083 ( .A(n2777), .B(n2778), .Y(n2772) );
  XNOR2X1 U3084 ( .A(next_haddr[1]), .B(n2770), .Y(n2778) );
  INVX1 U3085 ( .A(next_hwrite), .Y(n2777) );
  INVX1 U3086 ( .A(hrdata[0]), .Y(n2764) );
  INVX1 U3087 ( .A(n2615), .Y(n2618) );
  NAND2X1 U3088 ( .A(n2779), .B(n2780), .Y(n2615) );
  OR2X1 U3089 ( .A(n2781), .B(n2782), .Y(next_data_state[1]) );
  OAI21X1 U3090 ( .A(n2783), .B(n2784), .C(n2785), .Y(n2782) );
  NAND3X1 U3091 ( .A(n2779), .B(hwrite), .C(n2415), .Y(n2784) );
  NAND3X1 U3092 ( .A(n2786), .B(n2787), .C(n2788), .Y(n2783) );
  NOR2X1 U3093 ( .A(n2835), .B(N1490), .Y(n2788) );
  INVX1 U3094 ( .A(\next_slavedata[10][0] ), .Y(n2787) );
  NAND2X1 U3095 ( .A(n2789), .B(n2790), .Y(next_data_state[0]) );
  INVX1 U3096 ( .A(n2781), .Y(n2790) );
  OAI21X1 U3097 ( .A(n2791), .B(n2792), .C(n2446), .Y(n2781) );
  AOI22X1 U3098 ( .A(n2415), .B(\next_slavedata[10][0] ), .C(n2383), .D(n2686), 
        .Y(n2789) );
  OAI22X1 U3099 ( .A(n2524), .B(n2573), .C(n2574), .D(n2793), .Y(
        \next_slavedata[10][0] ) );
  INVX1 U3100 ( .A(\slavedata[10][0] ), .Y(n2793) );
  OAI22X1 U3101 ( .A(n2504), .B(n2794), .C(n2795), .D(n2796), .Y(n2574) );
  OAI21X1 U3102 ( .A(n2382), .B(n2797), .C(n2798), .Y(n2796) );
  NAND2X1 U3103 ( .A(n2799), .B(n2609), .Y(n2797) );
  INVX1 U3104 ( .A(n2800), .Y(n2382) );
  NAND3X1 U3105 ( .A(data_state[1]), .B(n2791), .C(data_state[2]), .Y(n2800)
         );
  OAI21X1 U3106 ( .A(n2569), .B(n2801), .C(n2502), .Y(n2504) );
  INVX1 U3107 ( .A(n2526), .Y(n2502) );
  OR2X1 U3108 ( .A(n2535), .B(n2151), .Y(n2801) );
  OR2X1 U3109 ( .A(n2794), .B(n2526), .Y(n2573) );
  NAND3X1 U3110 ( .A(next_hwrite), .B(addr[3]), .C(n2802), .Y(n2526) );
  AOI21X1 U3111 ( .A(n2535), .B(n2571), .C(n2803), .Y(n2802) );
  NAND2X1 U3112 ( .A(n2151), .B(n2571), .Y(n2794) );
  INVX1 U3113 ( .A(addr[2]), .Y(n2571) );
  INVX1 U3114 ( .A(n2500), .Y(n2524) );
  NAND2X1 U3115 ( .A(n2804), .B(n2805), .Y(n2500) );
  AOI22X1 U3116 ( .A(n2578), .B(hwdata[24]), .C(n2579), .D(hwdata[8]), .Y(
        n2805) );
  AND2X1 U3117 ( .A(n2501), .B(n2569), .Y(n2579) );
  NOR2X1 U3118 ( .A(n2806), .B(addr[1]), .Y(n2501) );
  AND2X1 U3119 ( .A(n2570), .B(n2569), .Y(n2578) );
  NOR2X1 U3120 ( .A(n2535), .B(n2806), .Y(n2570) );
  AOI22X1 U3121 ( .A(hwdata[0]), .B(n2580), .C(n2151), .D(hwdata[16]), .Y(
        n2804) );
  NOR2X1 U3122 ( .A(n2535), .B(addr[0]), .Y(n2508) );
  OAI21X1 U3123 ( .A(addr[1]), .B(n2569), .C(n2525), .Y(n2580) );
  NAND2X1 U3124 ( .A(n2806), .B(n2535), .Y(n2525) );
  INVX1 U3125 ( .A(addr[1]), .Y(n2535) );
  INVX1 U3126 ( .A(addr[0]), .Y(n2806) );
  INVX1 U3127 ( .A(next_hsize), .Y(n2569) );
  INVX1 U3128 ( .A(n2748), .Y(n2835) );
  INVX1 U3129 ( .A(n2374), .Y(tx_packet[2]) );
  NAND3X1 U3130 ( .A(n2369), .B(n2807), .C(\slavedata[12][2] ), .Y(n2374) );
  INVX1 U3131 ( .A(n2378), .Y(n2807) );
  NAND3X1 U3132 ( .A(n2808), .B(n2515), .C(n2809), .Y(n2378) );
  NOR2X1 U3133 ( .A(\slavedata[12][4] ), .B(\slavedata[12][3] ), .Y(n2809) );
  INVX1 U3134 ( .A(\slavedata[12][5] ), .Y(n2515) );
  NOR2X1 U3135 ( .A(\slavedata[12][7] ), .B(\slavedata[12][6] ), .Y(n2808) );
  NOR2X1 U3136 ( .A(\slavedata[12][1] ), .B(\slavedata[12][0] ), .Y(n2369) );
  MUX2X1 U3137 ( .B(n2810), .A(n2811), .S(n2527), .Y(n1090) );
  NAND2X1 U3138 ( .A(n2810), .B(n2812), .Y(n2811) );
  OAI21X1 U3139 ( .A(haddr[0]), .B(n2409), .C(n2528), .Y(n2812) );
  NAND2X1 U3140 ( .A(n2779), .B(n2813), .Y(n2409) );
  XNOR2X1 U3141 ( .A(n2528), .B(n2814), .Y(n1089) );
  AND2X1 U3142 ( .A(tx_state[0]), .B(n2810), .Y(n2814) );
  MUX2X1 U3143 ( .B(n2815), .A(n2816), .S(\next_slavedata[5][1] ), .Y(n2810)
         );
  NOR2X1 U3144 ( .A(tx_state[0]), .B(n2528), .Y(n2816) );
  NOR2X1 U3145 ( .A(tx_state[1]), .B(n2527), .Y(n2815) );
  INVX1 U3146 ( .A(tx_state[0]), .Y(n2527) );
  INVX1 U3147 ( .A(tx_state[1]), .Y(n2528) );
  OAI21X1 U3148 ( .A(n2817), .B(n2381), .C(n2446), .Y(n1088) );
  INVX1 U3149 ( .A(write), .Y(n2381) );
  NOR2X1 U3150 ( .A(n2415), .B(n2818), .Y(n2817) );
  MUX2X1 U3151 ( .B(n2795), .A(n2792), .S(n2819), .Y(n1087) );
  NOR2X1 U3152 ( .A(n2818), .B(n2820), .Y(n2819) );
  OAI21X1 U3153 ( .A(data_state[0]), .B(n2792), .C(n2446), .Y(n2820) );
  NAND3X1 U3154 ( .A(n2791), .B(n2821), .C(data_state[1]), .Y(n2446) );
  OAI21X1 U3155 ( .A(n2821), .B(n2791), .C(n2798), .Y(n2818) );
  INVX1 U3156 ( .A(n1008), .Y(n2798) );
  INVX1 U3157 ( .A(n2415), .Y(n2792) );
  NOR2X1 U3158 ( .A(data_state[1]), .B(data_state[2]), .Y(n2415) );
  INVX1 U3159 ( .A(get_rx_data), .Y(n2795) );
  OAI21X1 U3160 ( .A(\slavedata[11][0] ), .B(n2609), .C(n2822), .Y(n1008) );
  AOI21X1 U3161 ( .A(n2383), .B(n2686), .C(n2384), .Y(n2822) );
  INVX1 U3162 ( .A(n2785), .Y(n2384) );
  NAND3X1 U3163 ( .A(data_state[2]), .B(n2823), .C(data_state[0]), .Y(n2785)
         );
  INVX1 U3164 ( .A(\slavedata[11][1] ), .Y(n2686) );
  INVX1 U3165 ( .A(n2799), .Y(n2383) );
  NAND3X1 U3166 ( .A(n2791), .B(n2823), .C(data_state[2]), .Y(n2799) );
  INVX1 U3167 ( .A(data_state[1]), .Y(n2823) );
  INVX1 U3168 ( .A(data_state[0]), .Y(n2791) );
  NAND3X1 U3169 ( .A(data_state[1]), .B(n2821), .C(data_state[0]), .Y(n2609)
         );
  INVX1 U3170 ( .A(data_state[2]), .Y(n2821) );
  INVX1 U3171 ( .A(hready), .Y(hresp) );
  NAND2X1 U3172 ( .A(hsel), .B(n2824), .Y(hready) );
  XNOR2X1 U3173 ( .A(n2748), .B(n2825), .Y(N1339) );
  NOR2X1 U3174 ( .A(n2747), .B(n2826), .Y(n2825) );
  MUX2X1 U3175 ( .B(addr[3]), .A(haddr[3]), .S(n2779), .Y(n2748) );
  XNOR2X1 U3176 ( .A(n2826), .B(n2834), .Y(N1338) );
  INVX1 U3177 ( .A(n2747), .Y(n2834) );
  MUX2X1 U3178 ( .B(addr[2]), .A(haddr[2]), .S(n2779), .Y(n2747) );
  INVX1 U3179 ( .A(n2827), .Y(N1337) );
  OAI21X1 U3180 ( .A(N1490), .B(\next_address[1] ), .C(n2826), .Y(n2827) );
  NAND2X1 U3181 ( .A(N1490), .B(\next_address[1] ), .Y(n2826) );
  INVX1 U3182 ( .A(n2786), .Y(\next_address[1] ) );
  MUX2X1 U3183 ( .B(addr[1]), .A(n2828), .S(n2779), .Y(n2786) );
  NOR2X1 U3184 ( .A(n2567), .B(n2770), .Y(n2828) );
  NOR2X1 U3185 ( .A(n2562), .B(n2557), .Y(n2567) );
  NOR2X1 U3186 ( .A(n2829), .B(hsize[1]), .Y(n2557) );
  INVX1 U3187 ( .A(n2836), .Y(N1490) );
  MUX2X1 U3188 ( .B(addr[0]), .A(n2830), .S(n2779), .Y(n2836) );
  NOR2X1 U3189 ( .A(n2803), .B(n2824), .Y(n2779) );
  OAI21X1 U3190 ( .A(n2829), .B(n2771), .C(n2831), .Y(n2824) );
  MUX2X1 U3191 ( .B(n2813), .A(n2832), .S(haddr[2]), .Y(n2831) );
  MUX2X1 U3192 ( .B(n2780), .A(n2770), .S(haddr[3]), .Y(n2832) );
  INVX1 U3193 ( .A(hwrite), .Y(n2780) );
  INVX1 U3194 ( .A(n2833), .Y(n2813) );
  NAND3X1 U3195 ( .A(haddr[3]), .B(n2770), .C(hwrite), .Y(n2833) );
  INVX1 U3196 ( .A(haddr[1]), .Y(n2770) );
  INVX1 U3197 ( .A(hsize[1]), .Y(n2771) );
  INVX1 U3198 ( .A(hsize[0]), .Y(n2829) );
  INVX1 U3199 ( .A(hsel), .Y(n2803) );
  AND2X1 U3200 ( .A(haddr[0]), .B(n2562), .Y(n2830) );
  NOR2X1 U3201 ( .A(hsize[0]), .B(hsize[1]), .Y(n2562) );
endmodule

