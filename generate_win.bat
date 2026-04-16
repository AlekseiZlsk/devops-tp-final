@echo off
echo Recuperation des IPs depuis Windows...

for /f "tokens=2" %%a in ('vagrant ssh k3s -c "hostname -I" 2^>nul') do set K3S_IP=%%a
for /f "tokens=2" %%a in ('vagrant ssh monitoring -c "hostname -I" 2^>nul') do set MON_IP=%%a

if "%K3S_IP%"=="" for /f "tokens=1" %%a in ('vagrant ssh k3s -c "hostname -I" 2^>nul') do set K3S_IP=%%a
if "%MON_IP%"=="" for /f "tokens=1" %%a in ('vagrant ssh monitoring -c "hostname -I" 2^>nul') do set MON_IP=%%a

(
echo [k3s]
echo %K3S_IP% ansible_user=vagrant ansible_ssh_private_key_file=.vagrant/machines/k3s/virtualbox/private_key ansible_ssh_common_args='-o StrictHostKeyChecking=no'
echo.
echo [monitoring]
echo %MON_IP% ansible_user=vagrant ansible_ssh_private_key_file=.vagrant/machines/monitoring/virtualbox/private_key ansible_ssh_common_args='-o StrictHostKeyChecking=no'
echo.
echo [all:vars]
echo ansible_python_interpreter=/usr/bin/python3
) > ansible\inventory.ini

echo Inventaire genere avec succes !
pause