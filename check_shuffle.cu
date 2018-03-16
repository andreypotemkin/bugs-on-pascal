#include <stdio.h>

const int WARP_SIZE = 32;

__global__ void check_shuffle(float* a, float* total)
{
  __shared__ float values[WARP_SIZE];

  values[threadIdx.x] = a[threadIdx.x];
  __syncthreads();

  float val = a[threadIdx.x];

  if (threadIdx.x == 0)
    for (int i = 0; i < WARP_SIZE; i++)
    {
      float v1 =  __shfl(val, i);
      if (v1 != values[i])
        atomicAdd(total, 1);
    }
}


int main()
{
  float* data;
  cudaMallocManaged(&data, WARP_SIZE * sizeof(float));
  for (int i = 0; i < WARP_SIZE; i++)
    data[i] = i + 1;

  float* total;
  cudaMallocManaged(&total, sizeof(float));
  *total = 0.0;

  check_shuffle<<<1, 32>>>(data, total);
  cudaDeviceSynchronize();

  printf("computed %.1lf, while true is %.1f\n", *total, 0.0);

  cudaFree(total);
  cudaFree(data);
  return 0;
}
