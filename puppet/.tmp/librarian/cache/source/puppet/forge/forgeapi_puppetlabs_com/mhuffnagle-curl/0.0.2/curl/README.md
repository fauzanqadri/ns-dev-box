#curl

##Table of Contents

1. [Overview](#overview)
2. [Usage - Configuration options and additional functionality](#usage)
3. [Limitations - OS compatibility, etc.](#limitations)

##Overview

Very simply, this module makes sure that curl is installed.  Not interesting
on its own, but it helps other modules that depend on curl being present.

##Usage

```include curl```
```class { 'curl': }```

##Limitations

I've tested against Ubuntu.  Redhat-based systems are a little tougher to test
against, because curl is actually a dependency of the rpm package.  Has also
been tested against Solaris 11 thanks to LStuker.
