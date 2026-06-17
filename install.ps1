$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$sourceSkill = Join-Path $repoRoot "universal-handoff"
$targetSkill = Join-Path $env:USERPROFILE ".agents\skills\universal-handoff"
$agentsPath = Join-Path $env:USERPROFILE ".codex\AGENTS.md"
$agentsDir = Split-Path -Parent $agentsPath

if (-not (Test-Path -LiteralPath (Join-Path $sourceSkill "SKILL.md"))) {
  throw "Cannot find universal-handoff\SKILL.md next to install.ps1."
}

New-Item -ItemType Directory -Force -Path $targetSkill | Out-Null
Copy-Item -LiteralPath (Join-Path $sourceSkill "SKILL.md") -Destination (Join-Path $targetSkill "SKILL.md") -Force

New-Item -ItemType Directory -Force -Path $agentsDir | Out-Null
if (Test-Path -LiteralPath $agentsPath) {
  $existing = [System.IO.File]::ReadAllText($agentsPath, [System.Text.Encoding]::UTF8)
} else {
  $existing = ""
}

$rulesBase64 = "IyBVbml2ZXJzYWwgSGFuZG9mZiBSdWxlcwoK5omA5pyJ6aG555uu57uf5LiA5L2/55So5b2T5YmN6aG555uu55uu5b2V5LiL55qE77yaCgpgLmFpL0hBTkRPRkYubWRgCgrkvZzkuLrot6jnqpflj6PkuqTmjqXmlofmoaPjgIIKCmAuYWkvSEFORE9GRi5tZGAg5piv6Leo56qX5Y+j57un57ut5bel5L2c55qE5LqL5a6e5rqQ77yM5LiN6KaB5L6d6LWW6KKr5Y6L57yp55qE6IGK5aSp5LiK5LiL5paH5oGi5aSN6aG555uu54q25oCB44CCCgojIyDkuqTmjqUKCuW9k+eUqOaIt+i+k+WFpe+8mgoKLSDkuqTmjqUKLSDmm7TmlrDkuqTmjqUKLSDnlJ/miJDkuqTmjqUKLSDlvIDmlrDnqpcKLSDlh4blpIfmlrDnqpflj6MKLSDkuIrkuIvmloflv6vmu6HkuoYKLSDljovnvKnliY3kv53lrZgKLSDkv53lrZjov5vluqYKLSDkv53lrZjlvIDlj5Hov5vluqYKCuWQq+S5ieaYr++8mgoKMS4g5L2/55SoIGB1bml2ZXJzYWwtaGFuZG9mZmAgU2tpbGzjgIIKMi4g5Zyo5b2T5YmN6aG555uu5Lit5Yib5bu65oiW5pu05pawIGAuYWkvSEFORE9GRi5tZGDjgIIKMy4g5YWI5omn6KGM6aG555uu55uY54K577yM5LiN5YeG55u05o6l5oC757uT44CCCjQuIOWGmeWFpeW9k+WJjemhueebrue7neWvuei3r+W+hO+8mmBQcm9qZWN0IHBhdGg6IDzlvZPliY3pobnnm67nu53lr7not6/lvoQ+YOOAggo1LiDlj6rorrDlvZXlkI7nu63lvIDlj5Hlv4Xpobvnn6XpgZPnmoTkv6Hmga/jgIIKNi4g5LiN5oC757uT5a6M5pW06IGK5aSp6K6w5b2V44CCCjcuIOS4jeS/ruaUueS4muWKoeS7o+egge+8jOmZpOmdnueUqOaIt+aYjuehruimgeaxguOAggo4LiDlrozmiJDlkI7lkYror4nnlKjmiLfvvJrmlrDnqpflj6PovpPlhaXigJznu63kuIrigJ3ljbPlj6/nu6fnu63jgIIKCiMjIOe7reS4igoK5b2T55So5oi36L6T5YWl77yaCgotIOe7reS4igotIOe7p+e7rQotIOaOpeedgOWBmgotIOaMieS6pOaOpee7p+e7rQotIOe7p+e7reS4iuasoQoK5ZCr5LmJ5piv77yaCgoxLiDmo4Dmn6XlvZPliY3pobnnm67mmK/lkKblrZjlnKggYC5haS9IQU5ET0ZGLm1kYOOAggoyLiDlpoLmnpzlrZjlnKjvvIzor7vlj5YgYC5haS9IQU5ET0ZGLm1kYOOAggozLiDlhYjmoLjlr7kgYFByb2plY3QgcGF0aGAg5piv5ZCm5ZKM5b2T5YmN6aG555uu55uu5b2V5LiA6Ie044CCCjQuIOWmguaenCBgUHJvamVjdCBwYXRoYCDkuI3kuIDoh7TvvIzlgZzmraLnu6fnu63lubbmj5DphpLnlKjmiLfliIfmjaLliLDmraPnoa7pobnnm67nm67lvZXjgIIKNS4g5aaC5p6cIGBQcm9qZWN0IHBhdGhgIOe8uuWkse+8jOaPkOekuueUqOaIt+ivpeS6pOaOpeaWh+aho+e8uuWwkemhueebrui3r+W+hO+8jOmcgOimgeS6uuW3peehruiupOW9k+WJjeebruW9leaYr+WQpuato+ehruOAggo2LiDmjInnhacgYC5haS9IQU5ET0ZGLm1kYCDnmoTigJzkuIvkuIDmraXliqjkvZzigJ3nu6fnu63jgIIKNy4g5LiN6YeN5paw5oC757uT44CCCjguIOS4jeabtOaWsCBgLmFpL0hBTkRPRkYubWRg44CCCjkuIOS4jeiwg+eUqCBgdW5pdmVyc2FsLWhhbmRvZmZg44CCCjEwLiDkv67mlLnmlofku7bliY3vvIzlhYjmo4Dmn6XlvZPliY3mlofku7bnirbmgIHvvIzpgb/lhY3opobnm5blt7LmnInmlLnliqjjgIIKCuWmguaenCBgLmFpL0hBTkRPRkYubWRgIOS4jeWtmOWcqO+8jOaPkOekuueUqOaIt+W9k+WJjemhueebrui/mOayoeacieS6pOaOpeaWh+aho++8jOW5tuW7uuiurui+k+WFpeKAnOS6pOaOpeKAneOAggoKIyMg5Lqk5o6l6Ziy5ryP6KeE5YiZCgrlvZPnlKjmiLfovpPlhaXigJzkuqTmjqXigJ3igJzkv53lrZjov5vluqbigJ3igJzkv53lrZjlvIDlj5Hov5vluqbigJ3ml7bvvIzlv4XpobvlhYjnm5jngrnpobnnm67vvIzlho3mm7TmlrAgYC5haS9IQU5ET0ZGLm1kYOOAggoK5Lqk5o6l5paH5qGj5b+F6aG76KaG55uW77yaCgotIOeUqOaIt+aYjuehruimgeaxggotIOemgeatouS/ruaUuemhuQotIOW3suWujOaIkOW3peS9nAotIOacrOi9ruaUueWKqOaWh+S7tgotIGdpdCBzdGF0dXMKLSBnaXQgZGlmZgotIOacquWujOaIkOS6i+mhuQotIOW3suefpemXrumimAotIOW+heehruiupOS6i+mhuQotIOmqjOivgea4heWNlQotIOS4i+S4gOatpeWKqOS9nAotIFByb2plY3QgcGF0aAoK5aaC5p6c5L+h5oGv5LiN56Gu5a6a77yM5b+F6aG75YaZ4oCc5b6F56Gu6K6k4oCd77yM5LiN6IO954yc44CCCgrlpoLmnpzkv6Hmga/kuI3nn6XpgZPmlL7lk6rph4zvvIzlhpnlhaXigJzmnKrlvZLnsbvkvYblj6/og73ph43opoHigJ3vvIzkuI3og73kuKLlvIPjgIIKCiMjIOmYsuatouWPjeWkjeS6pOaOpQoK55So5oi36L6T5YWl4oCc57ut5LiK4oCd4oCc57un57ut4oCd4oCc5o6l552A5YGa4oCd4oCc5oyJ5Lqk5o6l57un57ut4oCd5pe277yM5Y+q6K+75Y+WIGAuYWkvSEFORE9GRi5tZGAg5bm257un57ut44CCCgrkuI3opoHlho3mrKHnlJ/miJDkuqTmjqXjgIIKCuWPquacieeUqOaIt+aYjuehrui+k+WFpeKAnOS6pOaOpeKAneKAnOabtOaWsOS6pOaOpeKAneKAnOS/neWtmOi/m+W6puKAneKAnOS/neWtmOW8gOWPkei/m+W6puKAneaXtu+8jOaJjeabtOaWsCBgLmFpL0hBTkRPRkYubWRg44CC"
$rules = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($rulesBase64))

$utf8NoBom = [System.Text.UTF8Encoding]::new($false)
if ($existing -notmatch "(?m)^# Universal Handoff Rules\s*$") {
  $separator = if ([string]::IsNullOrWhiteSpace($existing)) { "" } else { [Environment]::NewLine + [Environment]::NewLine }
  [System.IO.File]::WriteAllText($agentsPath, $existing.TrimEnd() + $separator + $rules.TrimEnd() + [Environment]::NewLine, $utf8NoBom)
  Write-Host "Installed universal-handoff and appended Universal Handoff Rules."
} else {
  Write-Host "Installed universal-handoff. Universal Handoff Rules already exist; skipped append."
}

Write-Host "Skill: $targetSkill"
Write-Host "Rules: $agentsPath"
