#
# 📖 [PyCUDAを使ってみよう](https://scrapbox.io/PythonOsaka/PyCUDA%E3%82%92%E4%BD%BF%E3%81%A3%E3%81%A6%E3%81%BF%E3%82%88%E3%81%86)
# 📖 [inducer/pycuda](https://github.com/inducer/pycuda/blob/main/examples/hello_gpu.py)
#
#   ```
#   cd lib_python
#   %windir%\system32\cmd.exe "/K" %USERPROFILE%\Anaconda3\Scripts\activate.bat %USERPROFILE%\Anaconda3
#   python hello_gpu.py
#   ```
#
import pycuda.autoinit
import pycuda.driver as drv
import numpy

from pycuda.compiler import SourceModule
mod = SourceModule("""
__global__ void multiply_them(float *dest, float *a, float *b)
{
  const int i = threadIdx.x;
  dest[i] = a[i] * b[i];
}
""")

multiply_them = mod.get_function("multiply_them")

# 葉局面で 400 だと遅い。しかし 400 でも 16 でも遅いから 400 ぐらい計算しないと意味ない
size = 400
a = numpy.random.randn(size).astype(numpy.float32)
b = numpy.random.randn(size).astype(numpy.float32)

dest = numpy.zeros_like(a)
multiply_them(
        drv.Out(dest), drv.In(a), drv.In(b),
        block=(size,1,1), grid=(1,1))

print(dest-a*b)
