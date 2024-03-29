# Build config file derived from seL4/configs/X64_verified.cmake

include(${CMAKE_CURRENT_LIST_DIR}/seL4/tools/helpers.cmake)
cmake_script_build_kernel()

# Basic x86_64 config options
set(KernelPlatform "pc99" CACHE STRING "")
set(KernelSel4Arch "x86_64" CACHE STRING "")

set(KernelVerificationBuild OFF CACHE BOOL "") # Not a verification build, default in X64_verified.cmake was ON

set(KernelMaxNumNodes "1" CACHE STRING "")
set(KernelOptimisation "-O2" CACHE STRING "")
set(KernelRetypeFanOutLimit "256" CACHE STRING "")
set(KernelBenchmarks "none" CACHE STRING "")
set(KernelDangerousCodeInjection OFF CACHE BOOL "")
set(KernelFastpath ON CACHE BOOL "")

#set(KernelPrinting ON CACHE BOOL "") # Enable serial debug printing, default in X64_verified.cmake was OFF
#set(KernelColourPrinting OFF CACHE BOOL "")

set(KernelNumDomains 16 CACHE STRING "")
set(KernelMaxNumBootinfoUntypedCap 166 CACHE STRING "")
set(KernelRootCNodeSizeBits 19 CACHE STRING "")
set(KernelMaxNumBootinfoUntypedCaps 50 CACHE STRING "")


# Settings to support our qemu cpu (-cpu qemu64,pdpe1gb)
#set(KernelHugePage OFF CACHE BOOL "")
set(KernelFSGSBase "msr" CACHE STRING "")
set(KernelSupportPCID OFF CACHE BOOL "")
set(KernelFPU "FXSAVE" CACHE STRING "")


# arch/x86/config.cmake options
set(KernelX86MicroArch "generic" CACHE STRING "")   # Generic microarch
set(KernelIRQController "IOAPIC" CACHE STRING "")   # Use APIC
set(KernelMultiboot1Header OFF CACHE BOOL "")       # Only want multiboot2 header, by default both are ON
set(KernelMultibootGFXMode "text" CACHE STRING "")  # Prefer VGA text mode, we'll support RGB framebuffers and UEFI later

include(${CMAKE_CURRENT_LIST_DIR}/seL4/configs/seL4Config.cmake)