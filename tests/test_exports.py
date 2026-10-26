"""Parse the shipped files with native format readers, using only the stdlib."""

import json
import plistlib
import re
import subprocess
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
EXTRAS = ROOT / "extras"


class NativeThemeTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.p = json.loads((EXTRAS / "palette.json").read_text())

    def test_palette_contains_only_concrete_colors(self):
        def check(value):
            for color in value.values():
                if isinstance(color, dict):
                    check(color)
                else:
                    self.assertRegex(color, r"^#[0-9a-f]{6}$")

        check(self.p)
        self.assertEqual(self.p["bg"], "#cdb06a")

    def test_bat_preserves_semantic_roles_and_styles(self):
        with (EXTRAS / "bat/HuangPao.tmTheme").open("rb") as source:
            theme = plistlib.load(source)
        self.assertEqual(theme["name"], "HuangPao")
        self.assertEqual(theme["semanticClass"], "theme.light.huangpao")
        base = theme["settings"][0]["settings"]
        self.assertEqual(base["background"], self.p["bg"])
        self.assertEqual(base["foreground"], self.p["text"])
        scopes = {}
        for item in theme["settings"][1:]:
            for scope in item["scope"].split(", "):
                self.assertNotIn(scope, scopes, f"duplicate bat scope: {scope}")
                scopes[scope] = item["settings"]
        for scope, role in {
            "comment": "comment",
            "variable": "variable",
            "variable.parameter": "parameter",
            "variable.other.property": "property",
            "entity.name.function": "func",
            "entity.name.function.method": "method",
            "entity.name.type": "type",
            "constant.numeric": "number",
            "constant.language": "constant",
            "constant.character.escape": "escape",
            "keyword.control": "keyword",
            "punctuation": "punctuation",
            "string": "string",
        }.items():
            self.assertEqual(scopes[scope]["foreground"], self.p["syntax"][role], scope)
        self.assertEqual(scopes["comment"]["fontStyle"], "italic")
        self.assertEqual(scopes["entity.name.function"]["fontStyle"], "bold")

    def test_delta_is_valid_git_config(self):
        def option(name):
            return subprocess.check_output(
                [
                    "git",
                    "config",
                    "--file",
                    str(EXTRAS / "delta/huangpao.gitconfig"),
                    "--get",
                    f"delta.huangpao.{name}",
                ],
                text=True,
            ).strip()

        self.assertEqual(option("syntax-theme"), "HuangPao")
        self.assertEqual(option("light"), "true")
        self.assertEqual(option("dark"), "false")
        self.assertIn(self.p["bg"], option("zero-style"))
        self.assertIn(self.p["diff_add"], option("plus-style"))
        self.assertIn(self.p["diff_delete"], option("minus-style"))

    def test_alfred_large_dimensions_and_colors(self):
        theme = json.loads((EXTRAS / "alfred/HuangPao Light Large.alfredappearance").read_text())["alfredtheme"]
        self.assertEqual(theme["name"], "HuangPao Light Large")
        self.assertEqual(theme["window"]["width"], 760)
        self.assertEqual(theme["search"]["text"]["size"], 36)
        self.assertEqual(theme["result"]["text"]["size"], 18)
        for actual, expected in [
            (theme["window"]["color"], self.p["bg"]),
            (theme["search"]["background"], self.p["surface"]),
            (theme["result"]["backgroundSelected"], self.p["bg_selected"]),
            (theme["result"]["text"]["colorSelected"], self.p["text_strong"]),
        ]:
            self.assertEqual(actual, expected + "FF")
        with (EXTRAS / "alfred/huangpao.plist").open("rb") as source:
            identity = plistlib.load(source)
        self.assertEqual(identity["darkthemeuid"], identity["lightthemeuid"])
        self.assertRegex(identity["lightthemeuid"], r"^theme\.custom\.[0-9A-F-]{36}$")

    def test_slides_shares_editor_syntax_and_paper(self):
        theme = json.loads((EXTRAS / "slides/huangpao_theme.json").read_text())
        self.assertEqual(theme["document"]["background_color"], self.p["bg"])
        self.assertEqual(theme["code_block"]["background_color"], self.p["bg"])
        self.assertIsInstance(theme["paragraph"], dict)
        chroma = theme["code_block"]["chroma"]
        for token, role in {
            "comment": "comment",
            "keyword": "keyword",
            "name": "variable",
            "name_function": "func",
            "name_class": "type",
            "name_constant": "constant",
            "literal_number": "number",
            "literal_string": "string",
            "operator": "operator",
            "punctuation": "punctuation",
        }.items():
            self.assertEqual(chroma[token]["color"], self.p["syntax"][role], token)
        self.assertTrue(chroma["name_function"]["bold"])
        self.assertTrue(chroma["comment"]["italic"])

    def test_shell_and_tmux_files_keep_selections_distinct(self):
        fzf = EXTRAS / "fzf/huangpao.sh"
        subprocess.run(["sh", "-n", str(fzf)], check=True)
        actual = subprocess.check_output(
            ["sh", "-c", '. "$1"; printf "%s\\n%s\\n" "$FZF_THEME_NAME" "$FZF_THEME_COLOR"', "sh", str(fzf)],
            text=True,
        ).splitlines()
        self.assertEqual(actual[0], "HuangPao")
        colors = dict(value.split(":", 1) for value in actual[1].split(","))
        self.assertEqual(colors["preview-bg"], self.p["bg"])
        self.assertEqual(colors["bg"], self.p["terminal"]["sidebar_bg"])
        tmux = (EXTRAS / "tmux/huangpao.conf").read_text()
        self.assertIn(f"fg={self.p['terminal']['selection_fg']},bg={self.p['terminal']['selection_bg']}", tmux)
        self.assertIn("window-status-current-style", tmux)
        oh_my = (EXTRAS / "tmux/huangpao.oh-my-tmux.conf").read_text()
        self.assertEqual(len(re.findall(r"^tmux_conf_theme_colour_\d+=", oh_my, re.M)), 17)


if __name__ == "__main__":
    unittest.main()
