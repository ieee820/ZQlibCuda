#ifndef _ZQ_CUDA_POISSON_SOLVER_2D_CLOSEDOCTREEPOISSON_CUH_
#define _ZQ_CUDA_POISSON_SOLVER_2D_CLOSEDOCTREEPOISSON_CUH_

#include "ZQ_CUDA_PoissonSolver2D.cuh"
#include "ZQ_CUDA_PoissonSolver2D_OpenOctreePoisson.cuh"

namespace ZQ_CUDA_PoissonSolver2D
{
	/*********************  CUDA functions   *************************/
													
	/*** Closed Octree Poisson ***/
	void cu_SolveClosedOctreePoissonRedBlack_MAC(float* mac_u, float* mac_v, const bool* leaf0, const bool* leaf1, const bool* leaf2, const bool* leaf3, 
											const float div_per_volume, const int width, const int height, const int maxIter);
											
	void cu_SolveClosedOctreePoissonRedBlack_MAC(float* mac_u, float* mac_v, const bool* leaf0, const bool* leaf1, const bool* leaf2, const bool* leaf3, 
											const float div_per_volume, const int width, const int height, const int maxIter,
											const int level0_num_red, const int* level0_index_red, const int level0_num_black, const int* level0_index_black,
											const int level1_num_red, const int* level1_index_red, const int level1_num_black, const int* level1_index_black,
											const int level2_num_red, const int* level2_index_red, const int level2_num_black, const int* level2_index_black,
											const int level3_num_red, const int* level3_index_red, const int level3_num_black, const int* level3_index_black);

	void cu_SolveClosedOctreePoissonRedBlack_MAC(float* mac_u, float* mac_v, const bool* leaf0, const bool* leaf1, const bool* leaf2, const bool* leaf3, 
											const float div_per_volume, const int width, const int height, const int maxIter,
											const int level0_num_red, const int* level0_index_red, const int* level0_neighborinfo_red,
											const int level0_num_black, const int* level0_index_black, const int* level0_neighborinfo_black,
											const int level1_num_red, const int* level1_index_red, const int* level1_neighborinfo_red,
											const int level1_num_black, const int* level1_index_black, const int* level1_neighborinfo_black,
											const int level2_num_red, const int* level2_index_red, const int* level2_neighborinfo_red,
											const int level2_num_black, const int* level2_index_black, const int* level2_neighborinfo_black,
											const int level3_num_red, const int* level3_index_red, const int* level3_neighborinfo_red,
											const int level3_num_black, const int* level3_index_black, const int* level3_neighborinfo_black);	
																					
	/************ Closed Octree Poisson Kernels ****************/
	__global__
	void Adjust_MAC_u_ClosedOctreePoisson_Kernel(float* mac_u, const float* p_level0, const float* p_level1, const float* p_level2, const float* p_level3, const bool* leaf0,
														const bool* leaf1, const bool* leaf2, const bool* leaf3, const int width, const int height);
	
	__global__
	void Adjust_MAC_v_ClosedOctreePoisson_Kernel(float* mac_v, const float* p_level0, const float* p_level1, const float* p_level2, const float* p_level3, const bool* leaf0,
														const bool* leaf1, const bool* leaf2, const bool* leaf3, const int width, const int height);
														
	__global__
	void SolvePressure_ClosedOctreePoisson_level0_RedBlack_Kernel(float* p_level0, const float* p_level1, const float* p_level2, const float* p_level3, const float* divergence0, 
														const bool* leaf0, const bool* leaf1, const bool* leaf2, const bool* leaf3, const float div_per_volume, const int width, const int height, const bool redkernel);

	__global__
	void SolvePressure_ClosedOctreePoisson_level1_RedBlack_Kernel(const float* p_level0, float* p_level1, const float* p_level2, const float* p_level3, const float *divergence1,
														const bool* leaf0, const bool* leaf1, const bool* leaf2, const bool* leaf3, const float div_per_volume, const int width, const int height, const bool redkernel);
														
	__global__
	void SolvePressure_ClosedOctreePoisson_level2_RedBlack_Kernel(const float* p_level0, const float* p_level1, float* p_level2, const float* p_level3, const float *divergence2,
														const bool* leaf0, const bool* leaf1, const bool* leaf2, const bool* leaf3, const float div_per_volume, const int width, const int height, const bool redkernel);
														
	__global__
	void SolvePressure_ClosedOctreePoisson_level3_RedBlack_Kernel(const float* p_level0, const float* p_level1, const float* p_level2, float* p_level3, const float *divergence3,
														const bool* leaf0, const bool* leaf1, const bool* leaf2, const bool* leaf3, const float div_per_volume, const int width, const int height, const bool redkernel);
			
	/*** Another Implementation of Closed Octree Poisson ***/											
	__global__
	void SolvePressure_ClosedOctreePoisson_level0_RedBlack_Kernel(float* p_level0, const float* p_level1, const float* p_level2, const float* p_level3, const float* divergence0, 
														const bool* leaf0, const bool* leaf1, const bool* leaf2, const bool* leaf3, const float div_per_volume, const int width, const int height, 
														const int level0_num, const int* level0_index);

	__global__
	void SolvePressure_ClosedOctreePoisson_level1_RedBlack_Kernel(const float* p_level0, float* p_level1, const float* p_level2, const float* p_level3, const float* divergence1, 
														const bool* leaf0, const bool* leaf1, const bool* leaf2, const bool* leaf3, const float div_per_volume, const int width, const int height, 
														const int level1_num, const int* level1_index);
	__global__
	void SolvePressure_ClosedOctreePoisson_level2_RedBlack_Kernel(const float* p_level0, const float* p_level1, float* p_level2, const float* p_level3, const float* divergence2, 
														const bool* leaf0, const bool* leaf1, const bool* leaf2, const bool* leaf3, const float div_per_volume, const int width, const int height, 
														const int level2_num, const int* level2_index);
	
	__global__
	void SolvePressure_ClosedOctreePoisson_level3_RedBlack_Kernel(const float* p_level0, const float* p_level1, const float* p_level2, float* p_level3, const float* divergence3, 
														const bool* leaf0, const bool* leaf1, const bool* leaf2, const bool* leaf3, const float div_per_volume, const int width, const int height, 
														const int level3_num, const int* level3_index);
														
	/*** Third Implementation of Closed Octree Poisson ***/											
	__global__
	void SolvePressure_ClosedOctreePoisson_level0_RedBlack_Kernel(float* p_level0, const float* p_level1, const float* p_level2, const float* p_level3, const float* divergence0, 
														const float div_per_volume, const int width, const int height, 
														const int level0_num, const int* level0_index, const int* level0_neighborinfo);
														
	__global__
	void SolvePressure_ClosedOctreePoisson_level1_RedBlack_Kernel(const float* p_level0, float* p_level1, const float* p_level2, const float* p_level3, const float* divergence1, 
														const float div_per_volume, const int width, const int height, 
														const int level1_num, const int* level1_index, const int* level1_neighborinfo);
														
	__global__
	void SolvePressure_ClosedOctreePoisson_level2_RedBlack_Kernel(const float* p_level0, const float* p_level1, float* p_level2, const float* p_level3, const float* divergence2, 
														const float div_per_volume, const int width, const int height, 
														const int level2_num, const int* level2_index, const int* level2_neighborinfo);
														
	__global__
	void SolvePressure_ClosedOctreePoisson_level3_RedBlack_Kernel(const float* p_level0, const float* p_level1, const float* p_level2, float* p_level3, const float* divergence3, 
														const float div_per_volume, const int width, const int height, 
														const int level3_num, const int* level3_index, const int* level3_neighborinfo);

}

#endif