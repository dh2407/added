import { StoryModel } from '#/index'
import { SectionHandler } from '../SectionHandler';

export class StorySection {
    public story: StoryModel;

    private _sectionHandler: SectionHandler;
    private _currentSceneNumber: number;
    private _currentSegmentNumberInTheCurrentScene: number;
    private _currentSegmentNumberInAllScenes: number;

    constructor(sectionHandler: SectionHandler) {
        this._sectionHandler = sectionHandler;
        this._currentSceneNumber = 1;
        this._currentSegmentNumberInTheCurrentScene = 1;
        this._currentSegmentNumberInAllScenes = 1;
        this.story = sectionHandler.currentSection.story!;
    }

    private isLastSegmentInScene(): boolean {
        return this._currentSegmentNumberInTheCurrentScene === this.currentSceneTotalNumberOfSegments;
    }

    private isLastScene(): boolean {
        return this._currentSceneNumber === this.story.scenes.length;
    }

    private moveToNextScene() {
        this._currentSceneNumber++;
        this._currentSegmentNumberInTheCurrentScene = 1;
        this._currentSegmentNumberInAllScenes++;
    }

    private moveToNextSegment() {
        this._currentSegmentNumberInTheCurrentScene++;
        this._currentSegmentNumberInAllScenes++;
    }

    private isFirstSegmentInScene(): boolean {
        return this._currentSegmentNumberInTheCurrentScene === 1;
    }

    private isFirstScene(): boolean {
        return this._currentSceneNumber === 1;
    }

    private moveToPreviousScene() {
        this._currentSceneNumber--;
        this._currentSegmentNumberInTheCurrentScene = this.story?.scenes[this._currentSceneNumber - 1].segments.length;
        this._currentSegmentNumberInAllScenes--;
    }

    private moveToPreviousSegment() {
        this._currentSegmentNumberInTheCurrentScene--;
        this._currentSegmentNumberInAllScenes--;
    }

    private get currentSceneTotalNumberOfSegments(): number {
        return this.story.scenes[this._currentSceneNumber - 1].segments.length;
    }

    // provided to the view

    public goNext() {
        if (this.isLastSegmentInScene()) {
            if (this.isLastScene()) {
                this._sectionHandler.goToNextSection()
            } else {
                this.moveToNextScene();
            }
        } else {
            this.moveToNextSegment();
        }
    }

    public goPrevious() {
        if (this.isFirstSegmentInScene()) {
            if (this.isFirstScene()) {
                alert('This is the first scene.'); // this shouldn't be reached
            } else {
                this.moveToPreviousScene();
            }
        } else {
            this.moveToPreviousSegment();
        }
    }

    public get progressionValue(): number {
        return this._currentSegmentNumberInAllScenes;
    }

    public get scenesTotalNumberOfSegments(): number {
        return this.story.scenes.reduce((total, scene) => total + scene.segments.length, 0);
    }

    public get currentSceneImageSrc(): string {
        return this.story.scenes[this._currentSceneNumber - 1].image_url || "";
    }

    public get currentSegmentSoundSrc(): string | undefined {
        return this.story.scenes[this._currentSceneNumber - 1].segments[this._currentSegmentNumberInTheCurrentScene - 1].sound_url;
    }

    public get currentSegmentText(): string {
        return this.story.scenes[this._currentSceneNumber - 1].segments[this._currentSegmentNumberInTheCurrentScene - 1].text;
    }

    public get isNextButtonDisplayed(): boolean {
        return this.progressionValue <= this.scenesTotalNumberOfSegments;
    }

    public get isPreviousButtonDisplayed(): boolean {
        return this.progressionValue > 1;
    }
}
