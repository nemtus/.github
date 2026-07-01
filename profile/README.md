<div align="center">

<img src="https://nemtus.com/wp-content/uploads/2020/11/header_nemtus.png" alt="NEMTUS" width="360" />

# NEMTUS

### Building the NEM/Symbol developer ecosystem

NEMTUS is a Japanese non-profit advancing the **NEM/Symbol** blockchain — we build and maintain
open-source SDKs and node images, run the annual HACK+ hackathon, and publish learning material
so anyone can build on Symbol. Everything we make is open source and free to use.

[![Sponsor](https://img.shields.io/badge/Sponsor-NEMTUS-ea4aaa?logo=githubsponsors)](https://github.com/sponsors/nemtus)
[![Website](https://img.shields.io/badge/Website-nemtus.com-2ea44f)](https://nemtus.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**[💖 Sponsor](https://github.com/sponsors/nemtus) · [🌐 Website](https://nemtus.com/) · [🐦 X](https://x.com/nemtusofficial) · [💬 Discord](https://discord.gg/eAucJKNs3R)**

</div>

---

## 🎯 Mission

The NEM/Symbol blockchain is a stable, enterprise-grade platform with native multi-signature,
custom on-chain assets (mosaics), and a participation-rewarding PoS+ consensus. NEMTUS exists to
**lower the barrier to building on it** — through reliable open-source tooling, self-hostable node
images, hands-on events, and a welcoming community.

## 🧰 Build on Symbol

Libraries for building Symbol apps, in JavaScript/TypeScript and Python:

| Package | What it is | Links |
| --- | --- | --- |
| **@nemtus/symbol-sdk** | Recommended JavaScript/TypeScript SDK for Symbol | [npm](https://www.npmjs.com/package/@nemtus/symbol-sdk) ![npm](https://img.shields.io/npm/v/@nemtus/symbol-sdk) · [GitHub](https://github.com/nemtus/symbol) |
| **@nemtus/symbol-openapi** | OpenAPI specification of the Symbol (catapult) REST API | [npm](https://www.npmjs.com/package/@nemtus/symbol-openapi) ![npm](https://img.shields.io/npm/v/@nemtus/symbol-openapi) · [GitHub](https://github.com/nemtus/symbol) |
| **@nemtus/symbol-rest-api-client-axios** | Typed Symbol REST API client for Axios | [npm](https://www.npmjs.com/package/@nemtus/symbol-rest-api-client-axios) ![npm](https://img.shields.io/npm/v/@nemtus/symbol-rest-api-client-axios) · [GitHub](https://github.com/nemtus/symbol-rest-api-client) |
| **@nemtus/symbol-rest-api-client-fetch** | Typed Symbol REST API client for Fetch | [npm](https://www.npmjs.com/package/@nemtus/symbol-rest-api-client-fetch) ![npm](https://img.shields.io/npm/v/@nemtus/symbol-rest-api-client-fetch) · [GitHub](https://github.com/nemtus/symbol-rest-api-client) |
| **nemtus-symbol-sdk** | Symbol Python SDK (import module: `symbolchain`) | [PyPI](https://pypi.org/project/nemtus-symbol-sdk/) ![PyPI](https://img.shields.io/pypi/v/nemtus-symbol-sdk) · [GitHub](https://github.com/nemtus/symbol/tree/dev/sdk/python) |
| **nemtus-catparser** | Symbol catbuffer schema parser (Python) | [PyPI](https://pypi.org/project/nemtus-catparser/) ![PyPI](https://img.shields.io/pypi/v/nemtus-catparser) · [GitHub](https://github.com/nemtus/symbol/tree/dev/catbuffer/parser) |
| **nemtus-symbol-lightapi** | Lightweight Python wrapper for NEM/Symbol REST API calls (import module: `symbollightapi`) | [PyPI](https://pypi.org/project/nemtus-symbol-lightapi/) ![PyPI](https://img.shields.io/pypi/v/nemtus-symbol-lightapi) · [GitHub](https://github.com/nemtus/symbol-product/tree/dev/lightapi/python) |

> ℹ️ `@nemtus/symbol-sdk-typescript` is **deprecated** — please migrate to **@nemtus/symbol-sdk**.
>
> ℹ️ `@nemtus/symbol-sdk-openapi-generator-typescript-axios` is **deprecated** — please migrate to **@nemtus/symbol-rest-api-client-axios**.
>
> ℹ️ `@nemtus/symbol-sdk-openapi-generator-typescript-fetch` is **deprecated** — please migrate to **@nemtus/symbol-rest-api-client-fetch**.

## 🐳 Run a Symbol node

The recommended way to set up and run a node is the **shoestring** CLI — it generates the
configuration, certificates, and compose files for you, so you rarely run the container images
by hand:

| Package | What it is | Links |
| --- | --- | --- |
| **nemtus-symbol-shoestring** | Symbol node deployment & management CLI (import module: `shoestring`; NEMTUS mirror of upstream symbol-shoestring, using NEMTUS mirror images) | [PyPI](https://pypi.org/project/nemtus-symbol-shoestring/) ![PyPI](https://img.shields.io/pypi/v/nemtus-symbol-shoestring) · [GitHub](https://github.com/nemtus/symbol-product/tree/dev/tools/shoestring) |

shoestring deploys nodes using NEMTUS-hosted images defined in the
**[symbol-networks](https://github.com/nemtus/symbol-networks)** network-config mirror.

Under the hood it pulls these reproducible, self-hostable container images of the Symbol node
stack (built from canonical upstream sources, with SBOM + SLSA provenance) — also available for
direct/advanced use:

| Image | What it is | Pull |
| --- | --- | --- |
| **ghcr.io/nemtus/catapult-server** | Symbol `catapult-server` node (server, broker, recovery, tools) | `docker pull ghcr.io/nemtus/catapult-server:latest` · [packages](https://github.com/nemtus/symbol/pkgs/container/catapult-server) |
| **ghcr.io/nemtus/symbol-rest** | Symbol REST gateway (`symbol-api-rest`) | `docker pull ghcr.io/nemtus/symbol-rest:latest` · [packages](https://github.com/nemtus/symbol/pkgs/container/symbol-rest) |

## 🏆 NEMTUS Hackathon — HACK+

Our flagship annual hackathon for builders on Symbol, held every year since 2022.

- **Hackathon app** — registration & event management, built on Symbol and actively maintained:
  **[Open app](https://nemtus-hackathon.web.app/)** · [GitHub](https://github.com/nemtus/hackathon)
- **All editions** — [overview site](https://hackathon.nemtus.com/) ([repo](https://github.com/nemtus/hackathon-lp)):

  | Edition | Website | Source |
  | --- | --- | --- |
  | HACK+2026 | [hackathon-2026.nemtus.com](https://hackathon-2026.nemtus.com/) | — |
  | HACK+2025 | [hackathon-2025.nemtus.com](https://hackathon-2025.nemtus.com/) | [GitHub](https://github.com/nemtus/hackathon-lp-2025) |
  | HACK+2024 | [hackathon-2024.nemtus.com](https://hackathon-2024.nemtus.com/) | [GitHub](https://github.com/nemtus/hackathon-lp-2024) |
  | HACK+2023 | [hackathon-2023.nemtus.com](https://hackathon-2023.nemtus.com/) | [GitHub](https://github.com/nemtus/hackathon-lp-2023) |
  | HACK+2022 | [hackathon-2022.nemtus.com](https://hackathon-2022.nemtus.com/) | — |

## 🎓 Learn Symbol

- **"Quick Learning Symbol" techbooks** —
  [JavaScript](https://techbookfest.org/product/1iLNyYUUpfvh2EsB8qj0U0) ·
  [C#](https://techbookfest.org/product/rMKkMgBq9ZadJSecDytR9k) ·
  [PHP](https://techbookfest.org/product/f1xWii4u1BjUY6KcE3Bt6B)
- **Tech blog** — articles & tutorials on [Zenn](https://zenn.dev/nemtus)
  ([source](https://github.com/nemtus/tech-blog))

## 🌐 Community

- **XYMPOSIUM** — a community conference for the Symbol ecosystem
  ([GitHub](https://github.com/nemtus/symbol-community-xymposium-2024))
- Follow along and join in on [X](https://x.com/nemtusofficial) and [Discord](https://discord.gg/eAucJKNs3R)

## 🤝 Get involved

Contributors of every kind are welcome — code, docs, translations, and event help.

- ⭐ Star and watch the repos you use (start with [@nemtus/symbol-sdk](https://github.com/nemtus/symbol))
- 🐛 Open issues and pull requests — bug reports and fixes are all valued
- 🌍 Help translate docs and learning material into more languages
- 💬 Say hi on [X](https://x.com/nemtusofficial) / [Discord](https://discord.gg/eAucJKNs3R) and join an upcoming HACK+ event

## 💖 Support NEMTUS

NEMTUS is a non-profit; sponsorship directly funds open-source maintenance (SDKs and node images),
the HACK+ hackathon, and free learning material for the whole Symbol ecosystem.

**[→ Become a sponsor](https://github.com/sponsors/nemtus)**

---

<div align="center">

[Website](https://nemtus.com/) · [GitHub](https://github.com/nemtus) · [Zenn](https://zenn.dev/nemtus) · [Sponsor](https://github.com/sponsors/nemtus)

</div>
