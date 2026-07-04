# shellcheck shell=bash
# changelog.sh — shared helper sourced by harness-check and harness-upgrade.
# Not meant to be run directly.
#
# print_changelog_since <stamped-version> <harness-dir>
#
# Prints CHANGELOG.md sections for every tag reached in <harness-dir>'s
# history after <stamped-version>, under a "What changed" heading. Prints
# nothing if <stamped-version> doesn't resolve to a commit (e.g. a stamp
# from before this feature existed) or if there are no such tags.
print_changelog_since() {
  local stamped="$1" harness_dir="$2"
  local changelog="$harness_dir/CHANGELOG.md"
  [ -f "$changelog" ] || return 0

  local stamped_sha
  stamped_sha="$(git -C "$harness_dir" rev-parse "$stamped" 2>/dev/null)" || return 0

  local tag printed=0
  for tag in $(git -C "$harness_dir" tag --contains "$stamped_sha" --sort=creatordate 2>/dev/null); do
    # Skip the tag the stamped commit is exactly on, so we don't reprint
    # the version the project is already at.
    [ "$(git -C "$harness_dir" rev-parse "$tag")" = "$stamped_sha" ] && continue

    if grep -q "^## \[$tag\]" "$changelog"; then
      if [ "$printed" -eq 0 ]; then
        echo "What changed since your version:"
        printed=1
      fi
      echo
      awk -v tag="$tag" '
        $0 ~ ("^## \\[" tag "\\]") { p = 1 }
        p && /^## \[/ && $0 !~ ("^## \\[" tag "\\]") { exit }
        p
      ' "$changelog"
    fi
  done
}
