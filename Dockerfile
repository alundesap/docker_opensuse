FROM opensuse/leap:42.3
LABEL maintainer="andrew.lunde@sap.com"
LABEL distro="opensuse/leap"
LABEL version="42.3"
LABEL description="This is OpenSuSE the way I like it."

#The environment variables set using ENV will persist when a container is run from the resulting image. You can view the values using docker inspect, and change them using docker run --env <key>=<value>
ENV myName="Andrew Lunde"

#RUN zypper -n ar -p 1 'https://download.opensuse.org/repositories/devel:/gcc/openSUSE_Leap_42.2/devel:gcc.repo'
#RUN zypper -n ar -p 1 'https://download.opensuse.org/repositories/KDE:/Qt:/5.6/openSUSE_Leap_42.2/KDE:Qt:5.6.repo'

#RUN zypper -n --gpg-auto-import-keys install --no-recommends --auto-agree-with-licenses --force-resolution gcc48-c++ libQt5Widgets-devel libQt5Test-devel libQt5Gui-devel libQt5Core-devel cmake make
RUN zypper -n --gpg-auto-import-keys install --no-recommends --auto-agree-with-licenses --force-resolution cmake make vim htop openssl openssh tree \
		&& sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
		&& echo "root:Nirvana8484" | chpasswd \
		&& echo "Last command in RUN"

#The EXPOSE instruction does not actually publish the port. It functions as a type of documentation between the person who builds the image and the person who runs the container, about which ports are intended to be published. To actually publish the port when running the container, use the -p flag on docker run to publish and map one or more ports, or the -P flag to publish all exposed ports and map them to high-order ports.

COPY entrypoint.sh /usr/local/bin/

EXPOSE 22

ENTRYPOINT ["entrypoint.sh"]
