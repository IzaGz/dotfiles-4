##########
# Editors
##########

export EDITOR='vim'
export PAGER='less'
export VISUAL=$EDITOR
export SVN_EDITOR=$EDITOR
export BUNDLER_EDITOR=$EDITOR

if [[ $(uname) == Darwin ]]; then
  export BUNDLER_EDITOR="mvim"
fi

##########
# Paths
##########

export PATH="/usr/local/bin:/Applications/Postgres.app/Contents/Versions/9.3/bin:/usr/local/sbin:/usr/local/share/npm/bin:/usr/local/heroku/bin:${PATH}"

export GHC_DOT_APP="/Applications/ghc-7.8.3.app"
if [ -d "$GHC_DOT_APP" ]; then
  export PATH="${HOME}/.cabal/bin:${GHC_DOT_APP}/Contents/bin:${PATH}"
fi

export PATH="${HOME}/.bin:${PATH}"

export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

# Adding Homebrew man path
export MANPATH="/usr/local/share/man:${MANPATH}"

export NODEPATH="/usr/local/lib/node_modules"

export SUBLHOME="${HOME}/Library/Application Support/Sublime Text 2/Packages/User"

export ANDROID_HOME="/usr/local/opt/android-sdk"

export NLTK_DATA='/Users/rgrasso/.nltk_data'

# password-containing environment variables
[[ -r "$HOME/.secrets" ]] && source "$HOME/.secrets"

# Chruby
if [[ -e /usr/local/opt/chruby/share/chruby/chruby.sh ]]; then
  source /usr/local/opt/chruby/share/chruby/chruby.sh
  source /usr/local/opt/chruby/share/chruby/auto.sh
  [[ -r ~/.ruby-version ]] && chruby $(cat ~/.ruby-version)
  [[ -r ./.ruby-version ]] && chruby $(cat ./.ruby-version)
fi

# Remove the need for bundle exec ... or ./bin/...
# by adding ./bin to path if the current project is trusted
function add_trusted_local_bin_to_path() {
  if [[ -d "$PWD/.git" ]]; then
    # We've entered a project directory so clear our old local bin path
    export PATH=`echo "$PATH"|sed -e 's,[^:]*\.git/[^:]*bin:,,g'`

    if [[ -d "$PWD/.git/safe" ]]; then
      # We're in a trusted project directory so update our local bin path
      export PATH="$PWD/.git/safe/../../bin:$PATH"
    fi
  fi
}

# Make sure add_trusted_local_bin_to_path runs after chruby so we prepend the default
# Chruby gem paths
if [[ -n "$ZSH_VERSION" ]]; then
  if [[ ! "$preexec_functions" == *add_trusted_local_bin_to_path* ]]; then
    preexec_functions+=("add_trusted_local_bin_to_path")
  fi
fi
