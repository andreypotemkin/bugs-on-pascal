#include <stdio.h>

__global__ void check_atomic(float* total)
{
    atomicAdd(total, 1.0f);
}

int main()
{
  float* total;
  cudaMallocManaged(&total, sizeof(float));
  *total = 0.0;

  check_atomic<<<1, 32>>>(total);
  cudaDeviceSynchronize();

  printf("computed %.1lf, while true is %.1f\n", *total, 32.0);

  cudaFree(total);
  return 0;
}
