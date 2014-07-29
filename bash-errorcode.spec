Summary: Displays error code in command prompt, if return code is not 0.
Name: bash-errorcode
Version: 0.1
Release: 0%{?dist}
BuildArch: noarch
License: GPLv3
Group: Applications/System
Source0: https://raw.githubusercontent.com/daisaacson/bash-errorcode/${name}/%{name}-%{version}.tar.gz
Url: https://raw.githubusercontent.com/daisaacson/bash-errorcode/bash-errorcode
Buildroot: %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

%description
bash-errorcde is a bash profile that contains a function that prints
the error code in red, if the return code is not 0. 

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
* Mon Jul 28 2014 daisaacson <49328302+daisaacson@users.noreply.github.com> - 0.1-0
- Initial build
