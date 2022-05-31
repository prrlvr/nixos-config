{ pkgs, ... }:

{
  networking = {
    hostName = "shinji";
    useDHCP = false;
    interfaces.eno1.useDHCP = true;
    interfaces.wlp58s0.useDHCP = true;
  };

  time.timeZone = "Europe/Paris";

  sound.enable = false;
  hardware.pulseaudio.enable = false;

  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
    passwordAuthentication = false;
  };

  users.users.root.openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDPt2EkH0lV/VYjbYAvuFHPNumd39EvUVVgUs8kbTB8eLegDwXyAxmBb/t+JYpYUobUYWDW2mh+rhpOTrXOv+1Bks+X+aZlHs+h2PbC/ycWM5SfVjcfIACmVMMcsBlIhgQDxIfwUHl/Q6yQm92fheRIdu91R75qY2qW8NUtnH1+aEoRKEy0AUZ64kKBgB5wgG2ldT2zHBI54X0GuNTynv6NI2M3URvWV45J645sHP+EuEG7T/kvSGXVkwmMnzAAa5Yhcn4/25jWDi9Xx8j4esGEsaju68Dwe6CPSMPLMWI5cFqlijzKdQh/JD7SkaVQfOR8Z9/O1/66WEkYRSrtx0bg5aN8Ycqc1Wg7hNKkx7KAuBhu8e/fgiVEdbupcdgFB4hwu3wIB39v2NTkG2mbSTzdGvc32fluDB5wUwlGYHzZRbLabNFL3AQA1iarhbF1RX8KWyIYqb76XLmfiP4H/4Dj08ZvvNAQ7NUqdO/2nLijmmZQQDQqsWhtu7k7rYKW15gkTFO74hVegi6Tj/N28pqKGIvPVt5TLx9fq53EGMYJY/v/tU4l4YLrDr2AdIKqAvWbY/hQbAitB/60AQkuCC6nbGDZ8SvHXqDzNa6hE71BhMabckRVezrK4Ve9LIn3Mk8sIYN8DLz4WAsi7QjdCw1nUjybb0qYVSi8jMR1cx39uQ== prrlvr@prthpad" ];

  console.keyMap = "us";
}
