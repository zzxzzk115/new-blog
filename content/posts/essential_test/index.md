---
date: "2025-11-04T19:31:06Z"
title: "Essential Test"
tags: ["Test"]
categories: ["Test"]
summary: Essential test for blog post writting.
cover:
  image: msg.png
autonumbering: true
---

## Mathjax Test

### Inline Equations

This is an inline \(a^*=x-b^*\) equation.

### Block Equations

These are block equations:

\[a^*=x-b^*\]

\[ a^*=x-b^* \]

\[
a^*=x-b^*
\]

These are also block equations:

$$a^*=x-b^*$$

$$ a^*=x-b^* $$

$$
a^*=x-b^*
$$

### Example

The Rendering Equation:

\[
L_o(\mathbf{x}, \omega_o) = L_e(\mathbf{x}, \omega_o) + 
\int_{\Omega} f_r(\mathbf{x}, \omega_i, \omega_o) \, L_i(\mathbf{x}, \omega_i) \, (\omega_i \cdot \mathbf{n}) \, d\omega_i
\]

## Code Test

```cpp {linenos=inline hl_lines=[3,"17-18"]}
#include <bits/stdc++.h>

using namespace std;

enum class Color { Red, Green, Blue };

struct Vec3 {
    float x{}, y{}, z{};
    Vec3 operator+(const Vec3& o) const { return {x + o.x, y + o.y, z + o.z}; }
};

int main() {
    try {
        vector<Vec3> points{{1,2,3}, {4,5,6}};
        auto add = [](Vec3 a, Vec3 b){ return a + b; };
        Vec3 sum = add(points[0], points[1]);
        cout << fixed << setprecision(2);
        cout << "Sum: (" << sum.x << ", " << sum.y << ", " << sum.z << ")\n";

        Color c = Color::Green;
        if (c == Color::Green)
            cout << "It's green!\n";
    } catch (const exception& e) {
        cerr << "Error: " << e.what() << endl;
    }
}
```

## Image Test

This is an image from `/static/images/`

<!-- Will add prefix /new-blog/ -->
{{< figure src="/new-blog/images/test.png" title="This is a test image" >}}

This is an image in the same directory as this markdown source file.

<!-- Relative Path -->
{{< figure src="meshlets.png" title="This is a test image" >}}

## \<iframe\>Test

<iframe
  src="https://shader-slang.org/slang-playground/?target=WGSL&code=eJxlkW1r2zAQx9_7Uxx-ZUNiLaUbI1kLpekg4LJSp32xUooSn20xPSHJme3S7z75oWuWCfRCd_f_3f1PhMC2YhawoUJzhByFktYZ6tACBcupLOea07Y0qpY5FEhdbRBcRR1opWs-VTpshsSuBa5ozmTpaxCYoCVCYZTwNQ_3aRIETGhlvPgvdPUeMihzNF66CoKnj_xy6YVRWDmn7ZIQQ38nJXNVvastmr2SDqVL9kqQrmu67tdi8ZlwtjvU3NsgBgtLKqS5JYJah4YIzBklw2CWTL7nVivZ0UTLMoyfg6dCGUFdFJpyR7_2ke1o72z9rfD23PkliHbTI05Hza5u79Kb--cgG8Amc35BYMdHX2wr6k1GoR9Y1w6HdrIWrjL9kNHiywyG28ePwddXaerxm583Lz--R6GqnZdPY_WQg2L5uO5bymRUM-nOIGdWU7evtgN9s15C9viyPgnGwWsA_uR-s3esQR6dymYQDTi7N4gyYx3GcHEJo6w_w1L6POWYw8X0_o-TNG0M5AiTtKtTRsGZ1seQEZo0ficwn1okbex3-Y_yfDR_rbgyXjx9TzJ-Q4oHb2v6hdl7jxl8ij_6G_SrlEeUMfXmS97-AEacELw"
  width="800"
  height="1600"
  frameborder="0">
</iframe>


## Alert

> [!CAUTION]
> Content

> [!IMPORTANT]
> Content

> [!NOTE]
> Content

> [!TIP]
> Content

> [!WARNING]
> Content