---
title: "Considering Transfering to Nvidia Render Interface (NRI)"
date: 2025-11-15T14:32:35+00:00
categories: [Graphics]
tags: [NRI]
---

I recently found NRI and it’s really great. Unlike NVRHI, NRI has a cleaner design and modern Vulkan/DX12-ish low-level APIs. It also supports many modern features with official support, such as DLSS. As a PhD student specialising in VR & HPG, NRI seems to be the best RHI for my needs.

<!-- more -->

## NRI

GitHub link: https://github.com/NVIDIA-RTX/NRI

*NRI* is a modular, extensible, low-level abstract rendering interface that was designed to support all low-level features of D3D12 and Vulkan GAPIs. At the same time, it aims to simplify usage and reduce the amount of code needed (especially compared with VK).

Goals:
- Generalization and unification of D3D12 ([spec](https://microsoft.github.io/DirectX-Specs/)) and VK ([spec](https://registry.khronos.org/vulkan/specs/latest/html/vkspec.html))
- Explicitness (providing access to low-level features of modern GAPIs)
- Quality-of-life and high-level extensions (e.g., streaming and upscaling)
- Low overhead
- Cross-platform and platform independence (AMD/INTEL friendly)
- D3D11 support ([spec](https://microsoft.github.io/DirectX-Specs/d3d/archive/D3D11_3_FunctionalSpec.htm)) (as much as possible)

Non-goals:
- Exposing entities not existing in GAPIs
- High-level (D3D11-like) abstraction
- Hidden management of any kind (except for some high-level extensions where it's desired)
- Automatic barriers (better handled in a higher-level abstraction)

Supported GAPIs:
- Vulkan
- D3D12
- D3D11
- Metal (through [MoltenVK](https://github.com/KhronosGroup/MoltenVK))
- None / dummy (everything is supported but does nothing)

<details>
<summary>Required Vulkan extensions:</summary>

- for Vulkan < 1.3:
    - _VK_KHR_synchronization2_
    - _VK_KHR_dynamic_rendering_
    - _VK_KHR_copy_commands2_
    - _VK_KHR_maintenance4_ (optional, but recommended)
    - _VK_EXT_extended_dynamic_state_
- for Vulkan < 1.4:
    - _VK_KHR_push_descriptor
    - _VK_KHR_maintenance5 (optional, but recommended)
    - _VK_KHR_maintenance6 (optional, but recommended)
- for APPLE:
    - _VK_KHR_portability_enumeration_ (instance extension)
    - _VK_KHR_get_physical_device_properties2_ (instance extension)
    - _VK_KHR_portability_subset_

</details>

<details>
<summary>Supported Vulkan extensions:</summary>

- Instance:
    - _VK_KHR_get_surface_capabilities2_
    - _VK_KHR_surface_
    - _VK_KHR_win32_surface_ (_VK_KHR_xlib_surface_, _VK_KHR_wayland_surface_, _VK_EXT_metal_surface_)
    - _VK_EXT_swapchain_colorspace_
    - _VK_EXT_debug_utils_
- Device:
    - _VK_KHR_swapchain_
    - _VK_KHR_present_id_
    - _VK_KHR_present_wait_
    - _VK_KHR_swapchain_mutable_format_
    - _VK_KHR_maintenance7_
    - _VK_KHR_maintenance8_
    - _VK_KHR_maintenance9_
    - _VK_KHR_fragment_shading_rate_
    - _VK_KHR_pipeline_library_
    - _VK_KHR_ray_tracing_pipeline_
    - _VK_KHR_acceleration_structure_ (depends on _VK_KHR_deferred_host_operations_)
    - _VK_KHR_ray_query_
    - _VK_KHR_ray_tracing_position_fetch_
    - _VK_KHR_ray_tracing_maintenance1_
    - _VK_KHR_line_rasterization_
    - _VK_KHR_fragment_shader_barycentric_
    - _VK_KHR_shader_clock_
    - _VK_KHR_compute_shader_derivatives_
    - _VK_EXT_mutable_descriptor_type_
    - _VK_EXT_subgroup_size_control_
    - _VK_EXT_swapchain_maintenance1_
    - _VK_EXT_present_mode_fifo_latest_ready_
    - _VK_EXT_opacity_micromap_
    - _VK_EXT_sample_locations_
    - _VK_EXT_conservative_rasterization_
    - _VK_EXT_mesh_shader_
    - _VK_EXT_shader_atomic_float_
    - _VK_EXT_shader_atomic_float2_
    - _VK_EXT_memory_budget_
    - _VK_EXT_memory_priority_
    - _VK_EXT_image_sliced_view_of_3d_
    - _VK_EXT_custom_border_color_
    - _VK_EXT_image_robustness_
    - _VK_EXT_robustness2_
    - _VK_EXT_pipeline_robustness_
    - _VK_EXT_fragment_shader_interlock_
    - _VK_NV_low_latency2_
    - _VK_NVX_binary_import_
    - _VK_NVX_image_view_handle_

</details>

## Requirement

- [x] OpenXR
- [x] Multi-view
- [x] Raytracing
- [x] Mesh Shaders
- [ ] Wayland


Before I start coding, I need to make sure that it is possible to make it work with OpenXR SDK.

Fortunately, it supports both Vulkan and DX12 which means it should work with OpenXR.

Next, I need to check whether it supports multi-view, because that’s the baseline for many VR applications.

I notices that they do support Multi-View but VK_KHR_multiview is not listed in the README.md. Check out this issue: https://github.com/NVIDIA-RTX/NRI/issues/42

Finally, it should support real-time ray tracing and mesh shaders, and it does (^_^).

What about running it on an AMD GPU machine with Linux and Wayland? Currently, no. X11? Yes. However, I believe that support for Wayland will be added in the future.

## Why not just Vulkan or DX12

Since I’m using NVIDIA's techniques, it would be better to use their official, more powerful SDK. It can also save me time when it comes to integrating DLSS, FSR and similar features.

## Still experimental

Although it’s great, it has some limitations. For example, we can’t add a Vulkan extension directly; we have to consider the equivalent in DX12 instead. Fortunately, it’s a community-driven project, which means that others can contribute extensions and features to strengthen it. Its ability is sufficient for my studies for now.