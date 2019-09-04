module p7zip_jll
using Pkg, Pkg.BinaryPlatforms, Pkg.Artifacts, Libdl

# Load Artifacts.toml file
artifacts_toml = joinpath(@__DIR__, "Artifacts.toml")

# Extract all platforms
artifacts = Pkg.Artifacts.load_artifacts_toml(artifacts_toml, UUID("3f19e933-33d8-53b3-aaab-bd5110c3b7a0"))
platforms = [Pkg.Artifacts.unpack_platform(e, "p7zip", artifacts_toml) for e in artifacts["p7zip"]]

# Filter platforms based on what wrappers we've generated on-disk
platforms = filter(p -> isfile(joinpath(@__DIR__, "wrappers", triplet(p))), platforms)

# From the available options, choose the best platform
best_platform = select_platform(Dict(p => triplet(p) for p in platforms))

# Load the appropriate wrapper
include(joinpath(@__DIR__, "wrappers", "$(best_platform).jl"))

end  # module p7zip_jll
