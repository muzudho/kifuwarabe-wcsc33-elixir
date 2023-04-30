defmodule KifuwarabeWcsc33.CLI.CallPython.HelloGpu do
  def hello_gpu do
    {_output, _status} = System.cmd("python", ["hello_gpu.py"],
    [
      cd: "../lib_python",
      into: IO.stream(:stdio, :line)
    ])
    # IO.puts("finished. status:#{status}")
    # IO.inspect(output, label: "[hello_gpu] output")
    #
    # finished. status:0
    # [hello_gpu] output: %IO.Stream{device: :standard_io, raw: false, line_or_bytes: :line}


    {:ok, self()}
  end

end
