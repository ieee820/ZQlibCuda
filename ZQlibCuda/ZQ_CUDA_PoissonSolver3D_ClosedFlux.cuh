#ifndef _ZQ_CUDA_POISSON_SOLVER_3D_CLOSED_FLUX_CUH_
#define _ZQ_CUDA_POISSON_SOLVER_3D_CLOSED_FLUX_CUH_

#include "ZQ_CUDA_PoissonSolver3D.cuh"

namespace ZQ_CUDA_PoissonSolver3D
{
	/*Closed Flux Model
	*	minimize \int{||\mathbf{x}||^2} 
	*	s.t.  \nabla \cdot (\mathbf{x} + \mathbf{u}) - divpervolume = 0
	*	------------------------------------------------
	*	Augmented Lagranged Multiplier method
	*	Let div := \nabla \cdot \mathbf{u}
	*	for(each outer iter)
	*	{
	*		minimize_{x} \int x^2 - \lambda (\nabla \cdot x + div - divpervolume) + coeff/2*(\nabla \cdot x + div - divpervolume)^2   (1)
	*		\lambda -= coeff*(\nabla \cdot x + div - divpervolume);
	*		increase coeff
	*	}
	*	----------------------------------------------
	*	The first implementation use red-black methd to solve Eq.1
	*/
	
	/*********************  CUDA functions   *************************/
	
	/* First Implementation
	* outer iteration: Augmented Lagrange Multiplier method
	* inner iteration: red-black iteration
	*/
	void cu_SolveClosedFluxRedBlack_MAC(float* mac_u, float* mac_v, float* mac_w, const float div_per_volume, const int width, const int height, const int depth,
												const int outerIter, const int innerIter);
	
	void cu_SolveClosedFluxRedBlackwithOccupy_MAC(float* mac_u, float* mac_v, float* mac_w, const bool* occupy, const float div_per_volume, 
												const int width, const int height, const int depth, const int outerIter, const int innerIter);
	
	void cu_SolveClosedFluxRedBlackwithFaceRatio_MAC(float* mac_u, float* mac_v, float* mac_w, const bool* occupy, const float* unoccupyU, const float* unoccupyV, const float* unoccupyW,
												const float div_per_volume, const int width, const int height, const int depth, const int outerIter, const int innerIter);
													
	/*********************  Kernel functions       *************************/
	
	/****** First Implementation ClosedFlux kernels  *****/
	__global__
	void SolveFlux_ClosedFlux_u_RedBlack_Kernel(float* out_du, const float* du, const float* dv, const float* dw, const float* divergence, const float* lambda, const float aug_coeff,
										const float div_per_volume, const int width, const int height, const int depth, const bool redkernel);

	__global__
	void SolveFlux_ClosedFlux_v_RedBlack_Kernel(float* out_dv, const float* du, const float* dv, const float* dw, const float* divergence, const float* lambda, const float aug_coeff,
										const float div_per_volume, const int width, const int height, const int depth, const bool redkernel);
										
	__global__
	void SolveFlux_ClosedFlux_w_RedBlack_Kernel(float* out_dw, const float* du, const float* dv, const float* dw, const float* divergence, const float* lambda, const float aug_coeff,
										const float div_per_volume, const int width, const int height, const int depth, const bool redkernel);

	__global__
	void SolveFlux_ClosedFlux_occupy_u_RedBlack_Kernel(float* out_du, const float* du, const float* dv, const float* dw, const bool* occupy, const float* divergence, const float* lambda, const float aug_coeff,
										const float div_per_volume, const int width, const int height, const int depth, const bool redkernel);

	__global__
	void SolveFlux_ClosedFlux_occupy_v_RedBlack_Kernel(float* out_dv, const float* du, const float* dv, const float* dw, const bool* occupy, const float* divergence, const float* lambda, const float aug_coeff,
										const float div_per_volume, const int width, const int height, const int depth, const bool redkernel);
										
	__global__
	void SolveFlux_ClosedFlux_occupy_w_RedBlack_Kernel(float* out_dw, const float* du, const float* dv, const float* dw, const bool* occupy, const float* divergence, const float* lambda, const float aug_coeff,
										const float div_per_volume, const int width, const int height, const int depth, const bool redkernel);
									
	__global__
	void SolveFlux_ClosedFlux_FaceRatio_u_RedBlack_Kernel(float* out_du, const float* du, const float* dv, const float* dw, const bool* occupy, const float* unoccupyU, const float* unoccupyV, 
										const float* unoccupyW, const float* divergence, const float* lambda, const float aug_coeff,
										const float div_per_volume, const int width, const int height, const int depth, const bool redkernel);

	__global__
	void SolveFlux_ClosedFlux_FaceRatio_v_RedBlack_Kernel(float* out_dv, const float* du, const float* dv, const float* dw, const bool* occupy, const float* unoccupyU, const float* unoccupyV,
										const float* unoccupyW, const float* divergence, const float* lambda, const float aug_coeff,
										const float div_per_volume, const int width, const int height, const int depth, const bool kernel);
										
	__global__
	void SolveFlux_ClosedFlux_FaceRatio_w_RedBlack_Kernel(float* out_dw, const float* du, const float* dv, const float* dw, const bool* occupy, const float* unoccupyU, const float* unoccupyV,
										const float* unoccupyW, const float* divergence, const float* lambda, const float aug_coeff,
										const float div_per_volume, const int width, const int height, const int depth, const bool kernel);
}

#endif