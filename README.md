# Claude Skills 学习与实践

这是一个关于 **Claude Skills** 的学习、记录与实践项目。Claude Skills 是 Anthropic 推出的一项先进功能，允许用户通过模块化的方式扩展 Claude 的能力，使其能够执行特定的任务、遵循复杂的工程规范或集成领域专业知识。

## 🚀 核心资源

以下是本项目参考的核心资源及官方链接：

- **源代码示例仓库**：[agent-skills-examples](https://github.com/tech-shrimp/agent-skills-examples) (由 tech-shrimp 提供)
- **Skills 开放标准规范**：[agentskills.io/specification](https://agentskills.io/specification)
- **Awesome Claude Skills 列表**：[awesome-claude-skills](https://github.com/ComposioHQ/awesome-claude-skills)
- **Anthropic 官方 Skills 仓库**：[anthropics/skills](https://github.com/anthropics/skills)
- **本项目技能索引**：[INDEX.md](./INDEX.md) (预览所有可用技能)

---

## ⚡ 快速安装

你可以通过以下一行命令快速从 GitHub 下载并安装本项目中的所有 Skills：

```bash
curl -sSL https://raw.githubusercontent.com/hygkui/claude-skills/refs/heads/master/install.sh | bash
```
> **注意**：该脚本会自动将仓库中的 Skills 同步到你的 Claude 本地配置目录中。

---

## 💡 什么是 Claude Skills？

Claude Skills 是一种基于文件系统的插件机制。它允许 Claude 动态加载指令、脚本和资源，从而针对特定工作流进行“技能加点”。

### 主要特点：
- **渐进式加载 (Progressive Disclosure)**：Claude 最初只加载技能的名称和描述。只有当用户请求匹配时，才会加载完整的 `SKILL.md` 内容。这种机制极大地节省了 Token，并保证了长对话的效率。
- **模块化与可移植性**：每个技能通常包含一个 `SKILL.md`（包含 YAML 元数据和 Markdown 指令）以及可选的辅助脚本（如 Python）。
- **专家模式切换**：通过 Skills，你可以让 Claude 从一个通用的助手瞬间变为 PPT 制作专家、代码审计专家或专业的数据分析师。

## 🛠 如何开始？

1. **阅读规范**：访问 [agentskills.io](https://agentskills.io/specification) 了解技能包的结构要求。
2. **参考示例**：查看 [tech-shrimp](https://github.com/tech-shrimp/agent-skills-examples) 的示例仓库，快速上手编写自己的技能。
3. **探索社区**：在 [Awesome Claude Skills](https://github.com/ComposioHQ/awesome-claude-skills) 寻找灵感，看看大家都在开发什么样的技能。
4. **官方最佳实践**：学习 [Anthropic 官方仓库](https://github.com/anthropics/skills) 中的实现方式，特别是其文档处理技能（如 Excel, PDF 等）。

## 📝 许可证

本项目使用 [MIT](LICENSE) 许可证。
