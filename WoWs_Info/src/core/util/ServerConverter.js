import serverCode from '../../constant/value';

class ServerConverter {
  static toCode(index) {
    // Chinese server, asia
    if (index == 4) return 'asia';
    else return serverCode[index];
  }
}

export {ServerConverter};