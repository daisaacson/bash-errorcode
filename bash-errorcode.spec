Summary: Display error codes from commands in your bash prompt
Name: bash-errorcode
Version: 0.3
Release: 0%{?dist}
BuildArch: noarch
License: GPLv3
Group: Applications/System
Source0: https://raw.githubusercontent.com/daisaacson/bash-errorcode/${name}/%{name}-%{version}.tar.gz
Url: https://raw.githubusercontent.com/daisaacson/bash-errorcode/bash-errorcode
Buildroot: %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

%description
bash-errorcde is a bash profile that contains a functions that prints
error codes from previos commands.  Know what the error codes were from
your commands without having to echo $? or ${PIPESTATUS[*]}

%prep
%setup -q

%build

%install
rm -rf $RPM_BUILD_ROOT

install -m 0755 -d $RPM_BUILD_ROOT%{_sysconfdir}/profile.d
install -pm 0644 errorcode.sh $RPM_BUILD_ROOT%{_sysconfdir}/profile.d/

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root)
%attr(0644,root,root) %{_sysconfdir}/profile.d/*

%changelog
* Sat Aug 1 2014 daisaacson <49328302+daisaacson@users.noreply.github.com> - 0.3-0
- Detect if TERM supports color
- Add comments to script
- Format changes to functions to match output from the type bash builtin
- Update Spec Summary and descriptsion

* Tue Jul 29 2014 daisaacson <49328302+daisaacson@users.noreply.github.com> - 0.2-0
- Print error codes from $PIPESTATUS variable

* Mon Jul 28 2014 daisaacson <49328302+daisaacson@users.noreply.github.com> - 0.1-0
- Initial build
- Print error code from $?
