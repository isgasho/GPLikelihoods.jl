"""
    GaussianLikelihood(σ²)

Gaussian likelihood with `σ²` variance. This is to be used if we assume that the
uncertainity associated with the data follows a Gaussian distribution.

```math
    p(y|f) = Normal(y | f, σ²)
```
On calling, this would return a normal distribution with mean `f` and variance σ².
"""
struct GaussianLikelihood{T<:Real}
    σ²::Vector{T}
end

GaussianLikelihood() = GaussianLikelihood(1e-6)

GaussianLikelihood(σ²::Real) = GaussianLikelihood([σ²])

@functor GaussianLikelihood

(l::GaussianLikelihood)(f::Real) = Normal(f, sqrt(first(l.σ²)))

(l::GaussianLikelihood)(fs::AbstractVector{<:Real}) = MvNormal(fs, sqrt(first(l.σ²)))
