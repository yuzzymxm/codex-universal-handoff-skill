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

$rulesBase64 = "IyBVbml2ZXJzYWwgSGFuZG9mZiBSdWxlcwoK5omA5pyJ6aG555uu57uf5LiA5L2/55So5b2T5YmN6aG555uu55uu5b2V5LiL55qE77yaCgpgLmFpL0hBTkRPRkYubWRgCgrkvZzkuLrot6jnqpflj6PkuqTmjqXmlofmoaPjgIIKCmAuYWkvSEFORE9GRi5tZGAg5piv6Leo56qX5Y+j57un57ut5bel5L2c55qE5LqL5a6e5rqQ77yM5LiN6KaB5L6d6LWW6KKr5Y6L57yp55qE6IGK5aSp5LiK5LiL5paH5oGi5aSN6aG555uu54q25oCB44CCCgojIyDkuqTmjqUKCuW9k+eUqOaIt+i+k+WFpe+8mgoKLSDkuqTmjqUKLSDmm7TmlrDkuqTmjqUKLSDnlJ/miJDkuqTmjqUKLSDlvIDmlrDnqpcKLSDlh4blpIfmlrDnqpflj6MKLSDkuIrkuIvmloflv6vmu6HkuoYKLSDljovnvKnliY3kv53lrZgKLSDkv53lrZjov5vluqYKLSDkv53lrZjlvIDlj5Hov5vluqYKCuWQq+S5ieaYr++8mgoKMS4g5L2/55SoIGB1bml2ZXJzYWwtaGFuZG9mZmAgU2tpbGzjgIIKMi4g5b+F6aG75a6e6ZmF5Yib5bu65oiW5pu05paw5b2T5YmN6aG555uu55qEIGAuYWkvSEFORE9GRi5tZGDjgIIKMy4g5YWI5omn6KGM6aG555uu55uY54K577yM5LiN5YeG55u05o6l5oC757uT44CCCjQuIOWmguaenCBgLmFpL2Ag55uu5b2V5LiN5a2Y5Zyo77yM5YWI5Yib5bu66K+l55uu5b2V44CCCjUuIOWGmeWFpeW9k+WJjemhueebrue7neWvuei3r+W+hO+8mmBQcm9qZWN0IHBhdGg6IDzlvZPliY3pobnnm67nu53lr7not6/lvoQ+YOOAggo2LiDlj6rorrDlvZXlkI7nu63lvIDlj5Hlv4Xpobvnn6XpgZPnmoTkv6Hmga/jgIIKNy4g5LiN5oC757uT5a6M5pW06IGK5aSp6K6w5b2V44CCCjguIOS4jeS/ruaUueS4muWKoeS7o+egge+8jOmZpOmdnueUqOaIt+aYjuehruimgeaxguOAggo5LiDlhpnlrozlkI7lv4Xpobvmo4Dmn6UgYC5haS9IQU5ET0ZGLm1kYCDmmK/lkKblrZjlnKjjgIIKMTAuIOWujOaIkOWQjuWRiuivieeUqOaIt++8muaWsOeql+WPo+i+k+WFpeKAnOe7reS4iuKAneWNs+WPr+e7p+e7reOAggoK56aB5q2i6KGM5Li677yaCgotIOS4jeW+l+WPquWbnuWkjeS6pOaOpeaAu+e7k+iAjOS4jeWGmeaWh+S7tuOAggotIOS4jeW+l+WPquW7uuiuruS/neWtmOi3r+W+hOaIluetieW+heeUqOaIt+ehruiupOaYr+WQpuS/neWtmOOAggotIOS4jeW+l+m7mOiupOWGmeWIsCBgZG9jcy9IQU5ET0ZGLm1kYOOAgWBIQU5ET0ZGLm1kYCDmiJblvZPliY3pobnnm67kuYvlpJbjgIIKLSDlpoLmnpzml6Dms5XlhpnlhaXvvIzlv4Xpobvor7TmmI7igJzmnKrlhpnlhaXigJ3jgIHlpLHotKXljp/lm6Dlkoznm67moIfnu53lr7not6/lvoTjgIIKCuWujOaIkOWbnuWkjeW/hemhu+WMheWQq++8mgoKYGBgdGV4dArlt7LlhpnlhaU6IDzlvZPliY3pobnnm67nu53lr7not6/lvoQ+Ly5haS9IQU5ET0ZGLm1kCumqjOivgTog5paH5Lu25a2Y5ZyoCmBgYAoKIyMg57ut5LiKCgrlvZPnlKjmiLfovpPlhaXvvJoKCi0g57ut5LiKCi0g57un57utCi0g5o6l552A5YGaCi0g5oyJ5Lqk5o6l57un57utCi0g57un57ut5LiK5qyhCgrlkKvkuYnmmK/vvJoKCjEuIOajgOafpeW9k+WJjemhueebruaYr+WQpuWtmOWcqCBgLmFpL0hBTkRPRkYubWRg44CCCjIuIOWmguaenOWtmOWcqO+8jOivu+WPliBgLmFpL0hBTkRPRkYubWRg44CCCjMuIOWFiOaguOWvuSBgUHJvamVjdCBwYXRoYCDmmK/lkKblkozlvZPliY3pobnnm67nm67lvZXkuIDoh7TjgIIKNC4g5aaC5p6cIGBQcm9qZWN0IHBhdGhgIOS4jeS4gOiHtO+8jOWBnOatoue7p+e7reW5tuaPkOmGkueUqOaIt+WIh+aNouWIsOato+ehrumhueebruebruW9leOAggo1LiDlpoLmnpwgYFByb2plY3QgcGF0aGAg57y65aSx77yM5o+Q56S655So5oi36K+l5Lqk5o6l5paH5qGj57y65bCR6aG555uu6Lev5b6E77yM6ZyA6KaB5Lq65bel56Gu6K6k5b2T5YmN55uu5b2V5piv5ZCm5q2j56Gu44CCCjYuIOaMieeFpyBgLmFpL0hBTkRPRkYubWRgIOeahOKAnOS4i+S4gOatpeWKqOS9nOKAnee7p+e7reOAggo3LiDkuI3ph43mlrDmgLvnu5PjgIIKOC4g5LiN5pu05pawIGAuYWkvSEFORE9GRi5tZGDjgIIKOS4g5LiN6LCD55SoIGB1bml2ZXJzYWwtaGFuZG9mZmDjgIIKMTAuIOS/ruaUueaWh+S7tuWJje+8jOWFiOajgOafpeW9k+WJjeaWh+S7tueKtuaAge+8jOmBv+WFjeimhuebluW3suacieaUueWKqOOAggoK5aaC5p6cIGAuYWkvSEFORE9GRi5tZGAg5LiN5a2Y5Zyo77yM5o+Q56S655So5oi35b2T5YmN6aG555uu6L+Y5rKh5pyJ5Lqk5o6l5paH5qGj77yM5bm25bu66K6u6L6T5YWl4oCc5Lqk5o6l4oCd44CCCgojIyDkuqTmjqXpmLLmvI/op4TliJkKCuW9k+eUqOaIt+i+k+WFpeKAnOS6pOaOpeKAneKAnOS/neWtmOi/m+W6puKAneKAnOS/neWtmOW8gOWPkei/m+W6puKAneaXtu+8jOW/hemhu+WFiOebmOeCuemhueebru+8jOWGjeWunumZheabtOaWsCBgLmFpL0hBTkRPRkYubWRg44CCCgrkuqTmjqXmlofmoaPlv4Xpobvopobnm5bvvJoKCi0g55So5oi35piO56Gu6KaB5rGCCi0g56aB5q2i5L+u5pS56aG5Ci0g5bey5a6M5oiQ5bel5L2cCi0g5pys6L2u5pS55Yqo5paH5Lu2Ci0gZ2l0IHN0YXR1cwotIGdpdCBkaWZmCi0g5pyq5a6M5oiQ5LqL6aG5Ci0g5bey55+l6Zeu6aKYCi0g5b6F56Gu6K6k5LqL6aG5Ci0g6aqM6K+B5riF5Y2VCi0g5LiL5LiA5q2l5Yqo5L2cCi0gUHJvamVjdCBwYXRoCgrlpoLmnpzkv6Hmga/kuI3noa7lrprvvIzlv4XpobvlhpnigJzlvoXnoa7orqTigJ3vvIzkuI3og73njJzjgIIKCuWmguaenOS/oeaBr+S4jeefpemBk+aUvuWTqumHjO+8jOWGmeWFpeKAnOacquW9kuexu+S9huWPr+iDvemHjeimgeKAne+8jOS4jeiDveS4ouW8g+OAggoKIyMg6Ziy5q2i5Y+N5aSN5Lqk5o6lCgrnlKjmiLfovpPlhaXigJznu63kuIrigJ3igJznu6fnu63igJ3igJzmjqXnnYDlgZrigJ3igJzmjInkuqTmjqXnu6fnu63igJ3ml7bvvIzlj6ror7vlj5YgYC5haS9IQU5ET0ZGLm1kYCDlubbnu6fnu63jgIIKCuS4jeimgeWGjeasoeeUn+aIkOS6pOaOpeOAggoK5Y+q5pyJ55So5oi35piO56Gu6L6T5YWl4oCc5Lqk5o6l4oCd4oCc5pu05paw5Lqk5o6l4oCd4oCc5L+d5a2Y6L+b5bqm4oCd4oCc5L+d5a2Y5byA5Y+R6L+b5bqm4oCd5pe277yM5omN5pu05pawIGAuYWkvSEFORE9GRi5tZGDjgII="
$rules = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($rulesBase64))

$utf8NoBom = [System.Text.UTF8Encoding]::new($false)
if ($existing -match "(?m)^# Universal Handoff Rules\s*$") {
  $updated = [regex]::Replace($existing, "(?ms)^# Universal Handoff Rules\s*.*\z", $rules.TrimEnd() + [Environment]::NewLine)
  [System.IO.File]::WriteAllText($agentsPath, $updated, $utf8NoBom)
  Write-Host "Installed universal-handoff and updated Universal Handoff Rules."
} else {
  $separator = if ([string]::IsNullOrWhiteSpace($existing)) { "" } else { [Environment]::NewLine + [Environment]::NewLine }
  [System.IO.File]::WriteAllText($agentsPath, $existing.TrimEnd() + $separator + $rules.TrimEnd() + [Environment]::NewLine, $utf8NoBom)
  Write-Host "Installed universal-handoff and appended Universal Handoff Rules."
}

Write-Host "Skill: $targetSkill"
Write-Host "Rules: $agentsPath"
