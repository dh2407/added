export enum SoundStateEnum {
    STOPPED = 'STOPPED',
    PLAYING = 'PLAYING',
    PAUSED = 'PAUSED',
    ENDED = 'ENDED',
}

export class SoundHandler {
    private audio: HTMLAudioElement | null = null;
    // private _currentStatus: SoundStateEnum = SoundStateEnum.STOPPED; // not used yet
    private onStatusChange: (status: SoundStateEnum) => void;

    constructor(onStatusChange: (status: SoundStateEnum) => void) {
        this.onStatusChange = onStatusChange;
    }

    private updateStatus(newStatus: SoundStateEnum) {
        // this._currentStatus = newStatus;
        this.onStatusChange(newStatus);
    }

    public playSound(soundSrc: string) {
        this.stopSound();
        this.audio = new Audio(soundSrc);
        this.audio.play();
        this.updateStatus(SoundStateEnum.PLAYING);
        this.audio.onplay = () => this.updateStatus(SoundStateEnum.PLAYING);
        this.audio.onpause = () => this.updateStatus(SoundStateEnum.PAUSED);
        this.audio.onended = () => this.updateStatus(SoundStateEnum.ENDED);
    }

    public stopSound() {
        if (this.audio) {
            this.audio.pause();
            this.updateStatus(SoundStateEnum.STOPPED);
            this.audio = null;
        }
    }
}
