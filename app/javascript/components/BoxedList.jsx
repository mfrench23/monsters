import React from "react"
import PropTypes from "prop-types"

class BoxedList extends React.Component {
  constructor(props) {
    super(props);
    this.state = { isVisible: false };
    this.toggleVisible = this.toggleVisible.bind(this);
    this.renderLink = this.renderLink.bind(this);
  }

  toggleVisible () {
    var iV = ! this.state.isVisible;
    this.setState( {isVisible: iV } );
  }

  renderLink(link) {
    if(link.url) {
      return (
        <a className="quiet" title={link.name} {...link.opts} href={link.url}>{link.name}</a>
      );
    } else {
      return (
        <span title={link.name}>{link.name}</span>
      );
    };
  }

  render () {
    var toggleLink = "";
    if( this.props.links.length ) {
      toggleLink = (
        <a className="quiet blue-highlight" href="#" onClick={this.toggleVisible}>
          &nbsp;{ this.state.isVisible ? "-" : "+" }&nbsp;
        </a>
      );
    }
    return (
      <span>
        <span style={{float: 'left'}} >{ toggleLink }</span>
        <div className="fixed-table">
          <div style={ this.state.isVisible ? {display: 'none'} : null }>
            <span className="bordered-grid footnote">{this.props.countHeader}</span>
          </div>
          <div style={ this.state.isVisible ? null : {display: 'none'} }>
            <ul className="bordered-grid loose-grid">
              { this.props.links.map((link, mIdx) => (
                <li key={link.name}>
                  { this.renderLink(link) }
                </li>
              ))}
            </ul>
          </div>
        </div>
      </span>
    );
  }
}

BoxedList.propTypes = {
  countHeader: PropTypes.string,
  links: PropTypes.array
};
export default BoxedList;
