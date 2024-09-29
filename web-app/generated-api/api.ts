/* tslint:disable */
/* eslint-disable */
/**
 * E-learning API
 * API for E-learning app.
 *
 * The version of the OpenAPI document: 1.0.0
 * 
 *
 * NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
 * https://openapi-generator.tech
 * Do not edit the class manually.
 */


import type { Configuration } from './configuration';
import type { AxiosPromise, AxiosInstance, RawAxiosRequestConfig } from 'axios';
import globalAxios from 'axios';
// Some imports not used depending on template conditions
// @ts-ignore
import { DUMMY_BASE_URL, assertParamExists, setApiKeyToObject, setBasicAuthToObject, setBearerAuthToObject, setOAuthToObject, setSearchParams, serializeDataIfNeeded, toPathString, createRequestFunction } from './common';
import type { RequestArgs } from './base';
// @ts-ignore
import { BASE_PATH, COLLECTION_FORMATS, BaseAPI, RequiredError, operationServerMap } from './base';

/**
 * 
 * @export
 * @interface ActionModel
 */
export interface ActionModel {
    /**
     * 
     * @type {string}
     * @memberof ActionModel
     */
    'id': string;
    /**
     * 
     * @type {string}
     * @memberof ActionModel
     */
    'next_section_id': string;
    /**
     * 
     * @type {string}
     * @memberof ActionModel
     */
    'label': string;
    /**
     * 
     * @type {object}
     * @memberof ActionModel
     */
    'params'?: object;
}
/**
 * 
 * @export
 * @interface ApiResponse
 */
export interface ApiResponse {
    /**
     * 
     * @type {SectionResponse}
     * @memberof ApiResponse
     */
    'data': SectionResponse;
    /**
     * 
     * @type {object}
     * @memberof ApiResponse
     */
    'error': object;
}
/**
 * 
 * @export
 * @interface MultipleChoiceQuestionModel
 */
export interface MultipleChoiceQuestionModel {
    /**
     * 
     * @type {string}
     * @memberof MultipleChoiceQuestionModel
     */
    'id': string;
    /**
     * 
     * @type {string}
     * @memberof MultipleChoiceQuestionModel
     */
    'html': string;
    /**
     * 
     * @type {string}
     * @memberof MultipleChoiceQuestionModel
     */
    'question_id': string;
    /**
     * 
     * @type {boolean}
     * @memberof MultipleChoiceQuestionModel
     */
    'is_single_response': boolean;
    /**
     * 
     * @type {Array<MultipleChoiceQuestionResponseModel>}
     * @memberof MultipleChoiceQuestionModel
     */
    'responses': Array<MultipleChoiceQuestionResponseModel>;
}
/**
 * 
 * @export
 * @interface MultipleChoiceQuestionResponseModel
 */
export interface MultipleChoiceQuestionResponseModel {
    /**
     * 
     * @type {string}
     * @memberof MultipleChoiceQuestionResponseModel
     */
    'id': string;
    /**
     * 
     * @type {string}
     * @memberof MultipleChoiceQuestionResponseModel
     */
    'html': string;
    /**
     * 
     * @type {string}
     * @memberof MultipleChoiceQuestionResponseModel
     */
    'multiple_choice_question_id': string;
    /**
     * 
     * @type {boolean}
     * @memberof MultipleChoiceQuestionResponseModel
     */
    'is_correct': boolean;
    /**
     * 
     * @type {string}
     * @memberof MultipleChoiceQuestionResponseModel
     */
    'explanation'?: string;
    /**
     * 
     * @type {number}
     * @memberof MultipleChoiceQuestionResponseModel
     */
    'selected_score'?: number;
    /**
     * 
     * @type {number}
     * @memberof MultipleChoiceQuestionResponseModel
     */
    'unselected_score'?: number;
}
/**
 * 
 * @export
 * @interface PageModel
 */
export interface PageModel {
    /**
     * 
     * @type {string}
     * @memberof PageModel
     */
    'id': string;
    /**
     * 
     * @type {string}
     * @memberof PageModel
     */
    'html': string;
    /**
     * 
     * @type {string}
     * @memberof PageModel
     */
    'background_color'?: string;
    /**
     * 
     * @type {Array<ActionModel>}
     * @memberof PageModel
     */
    'actions'?: Array<ActionModel>;
}
/**
 * 
 * @export
 * @enum {string}
 */

export const QuestionKindEnum = {
    FillInTheBlanksQuestion: 'FILL_IN_THE_BLANKS_QUESTION',
    MultipleChoiceQuestion: 'MULTIPLE_CHOICE_QUESTION'
} as const;

export type QuestionKindEnum = typeof QuestionKindEnum[keyof typeof QuestionKindEnum];


/**
 * 
 * @export
 * @interface QuestionModel
 */
export interface QuestionModel {
    /**
     * 
     * @type {string}
     * @memberof QuestionModel
     */
    'id': string;
    /**
     * 
     * @type {QuestionKindEnum}
     * @memberof QuestionModel
     */
    'kind': QuestionKindEnum;
    /**
     * 
     * @type {string}
     * @memberof QuestionModel
     */
    'question_game_id': string;
    /**
     * 
     * @type {number}
     * @memberof QuestionModel
     */
    'order': number;
    /**
     * 
     * @type {object}
     * @memberof QuestionModel
     */
    'fill_in_the_blanks_question'?: object;
    /**
     * 
     * @type {MultipleChoiceQuestionModel}
     * @memberof QuestionModel
     */
    'multiple_choice_question'?: MultipleChoiceQuestionModel;
}


/**
 * 
 * @export
 * @interface QuestionsGameModel
 */
export interface QuestionsGameModel {
    /**
     * 
     * @type {string}
     * @memberof QuestionsGameModel
     */
    'id': string;
    /**
     * 
     * @type {string}
     * @memberof QuestionsGameModel
     */
    'section_id': string;
    /**
     * 
     * @type {Array<QuestionModel>}
     * @memberof QuestionsGameModel
     */
    'questions': Array<QuestionModel>;
}
/**
 * 
 * @export
 * @interface SceneModel
 */
export interface SceneModel {
    /**
     * 
     * @type {string}
     * @memberof SceneModel
     */
    'image_url': string;
    /**
     * 
     * @type {Array<SegmentModel>}
     * @memberof SceneModel
     */
    'segments': Array<SegmentModel>;
}
/**
 * 
 * @export
 * @interface SectionGetFirstSectionPostRequest
 */
export interface SectionGetFirstSectionPostRequest {
    /**
     * 
     * @type {string}
     * @memberof SectionGetFirstSectionPostRequest
     */
    'subject_id': string;
}
/**
 * 
 * @export
 * @interface SectionGetNextSectionPostRequest
 */
export interface SectionGetNextSectionPostRequest {
    /**
     * 
     * @type {string}
     * @memberof SectionGetNextSectionPostRequest
     */
    'section_id': string;
}
/**
 * 
 * @export
 * @enum {string}
 */

export const SectionKindEnum = {
    Page: 'PAGE',
    Story: 'STORY',
    QuestionsGame: 'QUESTIONS_GAME'
} as const;

export type SectionKindEnum = typeof SectionKindEnum[keyof typeof SectionKindEnum];


/**
 * 
 * @export
 * @interface SectionResponse
 */
export interface SectionResponse {
    /**
     * 
     * @type {string}
     * @memberof SectionResponse
     */
    'section_id': string;
    /**
     * 
     * @type {SectionKindEnum}
     * @memberof SectionResponse
     */
    'kind': SectionKindEnum;
    /**
     * 
     * @type {StoryModel}
     * @memberof SectionResponse
     */
    'story'?: StoryModel;
    /**
     * 
     * @type {PageModel}
     * @memberof SectionResponse
     */
    'page'?: PageModel;
    /**
     * 
     * @type {QuestionsGameModel}
     * @memberof SectionResponse
     */
    'questions_game'?: QuestionsGameModel;
    /**
     * 
     * @type {boolean}
     * @memberof SectionResponse
     */
    'is_last': boolean;
}


/**
 * 
 * @export
 * @interface SegmentModel
 */
export interface SegmentModel {
    /**
     * 
     * @type {string}
     * @memberof SegmentModel
     */
    'text': string;
    /**
     * 
     * @type {string}
     * @memberof SegmentModel
     */
    'sound_url'?: string;
}
/**
 * 
 * @export
 * @interface StoryModel
 */
export interface StoryModel {
    /**
     * 
     * @type {string}
     * @memberof StoryModel
     */
    'id': string;
    /**
     * 
     * @type {Array<SceneModel>}
     * @memberof StoryModel
     */
    'scenes': Array<SceneModel>;
}

/**
 * DefaultApi - axios parameter creator
 * @export
 */
export const DefaultApiAxiosParamCreator = function (configuration?: Configuration) {
    return {
        /**
         * 
         * @summary Retrieve the first section based on the provided subject ID.
         * @param {SectionGetFirstSectionPostRequest} [sectionGetFirstSectionPostRequest] Subject ID to fetch the first section.
         * @param {*} [options] Override http request option.
         * @throws {RequiredError}
         */
        sectionGetFirstSectionPost: async (sectionGetFirstSectionPostRequest?: SectionGetFirstSectionPostRequest, options: RawAxiosRequestConfig = {}): Promise<RequestArgs> => {
            const localVarPath = `/section-get_first_section`;
            // use dummy base URL string because the URL constructor only accepts absolute URLs.
            const localVarUrlObj = new URL(localVarPath, DUMMY_BASE_URL);
            let baseOptions;
            if (configuration) {
                baseOptions = configuration.baseOptions;
            }

            const localVarRequestOptions = { method: 'POST', ...baseOptions, ...options};
            const localVarHeaderParameter = {} as any;
            const localVarQueryParameter = {} as any;


    
            localVarHeaderParameter['Content-Type'] = 'application/json';

            setSearchParams(localVarUrlObj, localVarQueryParameter);
            let headersFromBaseOptions = baseOptions && baseOptions.headers ? baseOptions.headers : {};
            localVarRequestOptions.headers = {...localVarHeaderParameter, ...headersFromBaseOptions, ...options.headers};
            localVarRequestOptions.data = serializeDataIfNeeded(sectionGetFirstSectionPostRequest, localVarRequestOptions, configuration)

            return {
                url: toPathString(localVarUrlObj),
                options: localVarRequestOptions,
            };
        },
        /**
         * 
         * @summary Retrieve the next section based on the provided section ID.
         * @param {SectionGetNextSectionPostRequest} [sectionGetNextSectionPostRequest] Section ID to fetch the next section.
         * @param {*} [options] Override http request option.
         * @throws {RequiredError}
         */
        sectionGetNextSectionPost: async (sectionGetNextSectionPostRequest?: SectionGetNextSectionPostRequest, options: RawAxiosRequestConfig = {}): Promise<RequestArgs> => {
            const localVarPath = `/section-get_next_section`;
            // use dummy base URL string because the URL constructor only accepts absolute URLs.
            const localVarUrlObj = new URL(localVarPath, DUMMY_BASE_URL);
            let baseOptions;
            if (configuration) {
                baseOptions = configuration.baseOptions;
            }

            const localVarRequestOptions = { method: 'POST', ...baseOptions, ...options};
            const localVarHeaderParameter = {} as any;
            const localVarQueryParameter = {} as any;


    
            localVarHeaderParameter['Content-Type'] = 'application/json';

            setSearchParams(localVarUrlObj, localVarQueryParameter);
            let headersFromBaseOptions = baseOptions && baseOptions.headers ? baseOptions.headers : {};
            localVarRequestOptions.headers = {...localVarHeaderParameter, ...headersFromBaseOptions, ...options.headers};
            localVarRequestOptions.data = serializeDataIfNeeded(sectionGetNextSectionPostRequest, localVarRequestOptions, configuration)

            return {
                url: toPathString(localVarUrlObj),
                options: localVarRequestOptions,
            };
        },
        /**
         * 
         * @summary Retrieve section based on the provided section ID.
         * @param {SectionGetNextSectionPostRequest} [sectionGetNextSectionPostRequest] Section ID to fetch.
         * @param {*} [options] Override http request option.
         * @throws {RequiredError}
         */
        sectionGetPost: async (sectionGetNextSectionPostRequest?: SectionGetNextSectionPostRequest, options: RawAxiosRequestConfig = {}): Promise<RequestArgs> => {
            const localVarPath = `/section-get`;
            // use dummy base URL string because the URL constructor only accepts absolute URLs.
            const localVarUrlObj = new URL(localVarPath, DUMMY_BASE_URL);
            let baseOptions;
            if (configuration) {
                baseOptions = configuration.baseOptions;
            }

            const localVarRequestOptions = { method: 'POST', ...baseOptions, ...options};
            const localVarHeaderParameter = {} as any;
            const localVarQueryParameter = {} as any;


    
            localVarHeaderParameter['Content-Type'] = 'application/json';

            setSearchParams(localVarUrlObj, localVarQueryParameter);
            let headersFromBaseOptions = baseOptions && baseOptions.headers ? baseOptions.headers : {};
            localVarRequestOptions.headers = {...localVarHeaderParameter, ...headersFromBaseOptions, ...options.headers};
            localVarRequestOptions.data = serializeDataIfNeeded(sectionGetNextSectionPostRequest, localVarRequestOptions, configuration)

            return {
                url: toPathString(localVarUrlObj),
                options: localVarRequestOptions,
            };
        },
    }
};

/**
 * DefaultApi - functional programming interface
 * @export
 */
export const DefaultApiFp = function(configuration?: Configuration) {
    const localVarAxiosParamCreator = DefaultApiAxiosParamCreator(configuration)
    return {
        /**
         * 
         * @summary Retrieve the first section based on the provided subject ID.
         * @param {SectionGetFirstSectionPostRequest} [sectionGetFirstSectionPostRequest] Subject ID to fetch the first section.
         * @param {*} [options] Override http request option.
         * @throws {RequiredError}
         */
        async sectionGetFirstSectionPost(sectionGetFirstSectionPostRequest?: SectionGetFirstSectionPostRequest, options?: RawAxiosRequestConfig): Promise<(axios?: AxiosInstance, basePath?: string) => AxiosPromise<ApiResponse>> {
            const localVarAxiosArgs = await localVarAxiosParamCreator.sectionGetFirstSectionPost(sectionGetFirstSectionPostRequest, options);
            const localVarOperationServerIndex = configuration?.serverIndex ?? 0;
            const localVarOperationServerBasePath = operationServerMap['DefaultApi.sectionGetFirstSectionPost']?.[localVarOperationServerIndex]?.url;
            return (axios, basePath) => createRequestFunction(localVarAxiosArgs, globalAxios, BASE_PATH, configuration)(axios, localVarOperationServerBasePath || basePath);
        },
        /**
         * 
         * @summary Retrieve the next section based on the provided section ID.
         * @param {SectionGetNextSectionPostRequest} [sectionGetNextSectionPostRequest] Section ID to fetch the next section.
         * @param {*} [options] Override http request option.
         * @throws {RequiredError}
         */
        async sectionGetNextSectionPost(sectionGetNextSectionPostRequest?: SectionGetNextSectionPostRequest, options?: RawAxiosRequestConfig): Promise<(axios?: AxiosInstance, basePath?: string) => AxiosPromise<ApiResponse>> {
            const localVarAxiosArgs = await localVarAxiosParamCreator.sectionGetNextSectionPost(sectionGetNextSectionPostRequest, options);
            const localVarOperationServerIndex = configuration?.serverIndex ?? 0;
            const localVarOperationServerBasePath = operationServerMap['DefaultApi.sectionGetNextSectionPost']?.[localVarOperationServerIndex]?.url;
            return (axios, basePath) => createRequestFunction(localVarAxiosArgs, globalAxios, BASE_PATH, configuration)(axios, localVarOperationServerBasePath || basePath);
        },
        /**
         * 
         * @summary Retrieve section based on the provided section ID.
         * @param {SectionGetNextSectionPostRequest} [sectionGetNextSectionPostRequest] Section ID to fetch.
         * @param {*} [options] Override http request option.
         * @throws {RequiredError}
         */
        async sectionGetPost(sectionGetNextSectionPostRequest?: SectionGetNextSectionPostRequest, options?: RawAxiosRequestConfig): Promise<(axios?: AxiosInstance, basePath?: string) => AxiosPromise<ApiResponse>> {
            const localVarAxiosArgs = await localVarAxiosParamCreator.sectionGetPost(sectionGetNextSectionPostRequest, options);
            const localVarOperationServerIndex = configuration?.serverIndex ?? 0;
            const localVarOperationServerBasePath = operationServerMap['DefaultApi.sectionGetPost']?.[localVarOperationServerIndex]?.url;
            return (axios, basePath) => createRequestFunction(localVarAxiosArgs, globalAxios, BASE_PATH, configuration)(axios, localVarOperationServerBasePath || basePath);
        },
    }
};

/**
 * DefaultApi - factory interface
 * @export
 */
export const DefaultApiFactory = function (configuration?: Configuration, basePath?: string, axios?: AxiosInstance) {
    const localVarFp = DefaultApiFp(configuration)
    return {
        /**
         * 
         * @summary Retrieve the first section based on the provided subject ID.
         * @param {SectionGetFirstSectionPostRequest} [sectionGetFirstSectionPostRequest] Subject ID to fetch the first section.
         * @param {*} [options] Override http request option.
         * @throws {RequiredError}
         */
        sectionGetFirstSectionPost(sectionGetFirstSectionPostRequest?: SectionGetFirstSectionPostRequest, options?: RawAxiosRequestConfig): AxiosPromise<ApiResponse> {
            return localVarFp.sectionGetFirstSectionPost(sectionGetFirstSectionPostRequest, options).then((request) => request(axios, basePath));
        },
        /**
         * 
         * @summary Retrieve the next section based on the provided section ID.
         * @param {SectionGetNextSectionPostRequest} [sectionGetNextSectionPostRequest] Section ID to fetch the next section.
         * @param {*} [options] Override http request option.
         * @throws {RequiredError}
         */
        sectionGetNextSectionPost(sectionGetNextSectionPostRequest?: SectionGetNextSectionPostRequest, options?: RawAxiosRequestConfig): AxiosPromise<ApiResponse> {
            return localVarFp.sectionGetNextSectionPost(sectionGetNextSectionPostRequest, options).then((request) => request(axios, basePath));
        },
        /**
         * 
         * @summary Retrieve section based on the provided section ID.
         * @param {SectionGetNextSectionPostRequest} [sectionGetNextSectionPostRequest] Section ID to fetch.
         * @param {*} [options] Override http request option.
         * @throws {RequiredError}
         */
        sectionGetPost(sectionGetNextSectionPostRequest?: SectionGetNextSectionPostRequest, options?: RawAxiosRequestConfig): AxiosPromise<ApiResponse> {
            return localVarFp.sectionGetPost(sectionGetNextSectionPostRequest, options).then((request) => request(axios, basePath));
        },
    };
};

/**
 * DefaultApi - object-oriented interface
 * @export
 * @class DefaultApi
 * @extends {BaseAPI}
 */
export class DefaultApi extends BaseAPI {
    /**
     * 
     * @summary Retrieve the first section based on the provided subject ID.
     * @param {SectionGetFirstSectionPostRequest} [sectionGetFirstSectionPostRequest] Subject ID to fetch the first section.
     * @param {*} [options] Override http request option.
     * @throws {RequiredError}
     * @memberof DefaultApi
     */
    public sectionGetFirstSectionPost(sectionGetFirstSectionPostRequest?: SectionGetFirstSectionPostRequest, options?: RawAxiosRequestConfig) {
        return DefaultApiFp(this.configuration).sectionGetFirstSectionPost(sectionGetFirstSectionPostRequest, options).then((request) => request(this.axios, this.basePath));
    }

    /**
     * 
     * @summary Retrieve the next section based on the provided section ID.
     * @param {SectionGetNextSectionPostRequest} [sectionGetNextSectionPostRequest] Section ID to fetch the next section.
     * @param {*} [options] Override http request option.
     * @throws {RequiredError}
     * @memberof DefaultApi
     */
    public sectionGetNextSectionPost(sectionGetNextSectionPostRequest?: SectionGetNextSectionPostRequest, options?: RawAxiosRequestConfig) {
        return DefaultApiFp(this.configuration).sectionGetNextSectionPost(sectionGetNextSectionPostRequest, options).then((request) => request(this.axios, this.basePath));
    }

    /**
     * 
     * @summary Retrieve section based on the provided section ID.
     * @param {SectionGetNextSectionPostRequest} [sectionGetNextSectionPostRequest] Section ID to fetch.
     * @param {*} [options] Override http request option.
     * @throws {RequiredError}
     * @memberof DefaultApi
     */
    public sectionGetPost(sectionGetNextSectionPostRequest?: SectionGetNextSectionPostRequest, options?: RawAxiosRequestConfig) {
        return DefaultApiFp(this.configuration).sectionGetPost(sectionGetNextSectionPostRequest, options).then((request) => request(this.axios, this.basePath));
    }
}



