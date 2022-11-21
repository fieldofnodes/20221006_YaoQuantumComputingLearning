############################################################################
# Title    : Basics of Yao Quantum Computing
# Author   : Jonathan Miller
# Date     : 20221006
# Aim      : To express the basics of quantum computing with Yao
############################################################################
using Pkg
Pkg.activate(".")

using Yao
using YaoPlots
using YaoExtensions

A(i, j) = control(i, j=>shift(2π/(1<<(i-j+1))))

B(n, k) = chain(n, j==k ? put(k=>H) : A(j, k) for j in k:n)

qft(n) = chain(B(n, k) for k in 1:n)

YaoPlots.plot(qft(3))

YaoPlots.plot(chain(X, Y, H))

YaoPlots.plot(chain(put(5, 2=>chain(H,X)),put(5, 3=>H)))


YaoPlots.plot(control(5, 3, 2=>H))

qft(3)

ArrayReg(bit"1010")
ArrayReg(ComplexF32, bit"1010")

variational_circuit(5, 3, [1=>2, 2=>3, 3=>4, 4=>5, 5=>1]) |> YaoPlots.plot


r = zero_state(5)

r |> variational_circuit(5, 3, [1=>2, 2=>3, 3=>4, 4=>5, 5=>1])

expect(heisenberg(5), r)

expect(heisenberg(5), r=>variational_circuit(5, 3, [1=>2, 2=>3, 3=>4, 4=>5, 5=>1]))

reg, ∇θ = expect'(heisenberg(5), zero_state(5)=>variational_circuit(5, 3, [1=>2, 2=>3, 3=>4, 4=>5, 5=>1]))

reg
∇θ