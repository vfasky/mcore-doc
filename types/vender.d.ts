declare module 'webpack-dev-server/*'
declare module 'fs-plus'
declare module 'glob'
declare module 'chokidar'

declare var require: {
    <T>(path: string): T;
    (paths: string[], callback: (...modules: any[]) => void): void;
    ensure: (paths: string[], callback: (require: <T>(path: string) => T) => void) => void;
}